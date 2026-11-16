import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../app/routes.dart';
import '../../app/strings.dart';
import '../../app/theme/tone_colors.dart';
import '../../core/audio/play_audio.dart';
import '../../core/pinyin/pinyin.dart';
import '../../core/utils/haptics.dart';
import '../../core/widgets/async_value_view.dart';
import '../../core/widgets/hanzi_text.dart';
import '../../data/models/pronunciation.dart';
import 'pronunciation_providers.dart';

/// Bảng pinyin tương tác: hàng = vận mẫu, cột = thanh mẫu, hàng/cột đầu được
/// ghim khi cuộn. Chạm vào ô → chọn thanh → phát âm.
class PinyinChartScreen extends ConsumerWidget {
  const PinyinChartScreen({super.key});

  static const _cellW = 64.0;
  static const _cellH = 48.0;
  static const _headerW = 56.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chart = ref.watch(pinyinChartProvider);
    return Scaffold(
      appBar: AppBar(title: const Text(S.pinyinChart)),
      body: AsyncValueView(value: chart, data: (c) => _table(context, c)),
    );
  }

  Widget _table(BuildContext context, PinyinChart chart) {
    final scheme = Theme.of(context).colorScheme;
    final rows = chart.finals.length + 1;
    final cols = chart.initials.length + 1;

    return TableView.builder(
      pinnedRowCount: 1,
      pinnedColumnCount: 1,
      rowCount: rows,
      columnCount: cols,
      columnBuilder: (i) => TableSpan(
        extent: FixedTableSpanExtent(i == 0 ? _headerW : _cellW),
      ),
      rowBuilder: (i) => TableSpan(
        extent: const FixedTableSpanExtent(_cellH),
        backgroundDecoration: TableSpanDecoration(
          color: i == 0 ? scheme.surfaceContainerHigh : null,
        ),
      ),
      cellBuilder: (context, v) {
        final r = v.row, c = v.column;
        if (r == 0 && c == 0) return const TableViewCell(child: SizedBox());
        if (r == 0) {
          final ini = chart.initials[c - 1];
          return TableViewCell(child: _Header(ini.isEmpty ? '∅' : ini));
        }
        final fin = chart.finals[r - 1];
        if (c == 0) {
          return TableViewCell(
            child: ColoredBox(
              color: scheme.surfaceContainerHigh,
              child: _Header(fin),
            ),
          );
        }
        final syl = chart.cell(chart.initials[c - 1], fin);
        return TableViewCell(
          child: syl == null ? const SizedBox() : _SyllableCell(syllable: syl),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Center(
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
      );
}

class _SyllableCell extends StatelessWidget {
  const _SyllableCell({required this.syllable});
  final Syllable syllable;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Material(
        color: scheme.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Haptics.tap();
            showModalBottomSheet<void>(
              context: context,
              showDragHandle: true,
              builder: (_) => ToneSheet(syllable: syllable),
            );
          },
          child: Center(child: Text(syllable.syllable)),
        ),
      ),
    );
  }
}

/// Bottom sheet chọn thanh cho một âm tiết. Thanh vừa nghe được ghi nhớ để
/// nút "Ghi âm" luyện đúng thanh đó.
class ToneSheet extends ConsumerStatefulWidget {
  const ToneSheet({super.key, required this.syllable});

  final Syllable syllable;

  @override
  ConsumerState<ToneSheet> createState() => _ToneSheetState();
}

class _ToneSheetState extends ConsumerState<ToneSheet> {
  late int _selected = widget.syllable.availableTones.first;

  Syllable get syllable => widget.syllable;

  void _play(int t) {
    setState(() => _selected = t);
    playAudio(ref, context,
        text: syllable.tones[t]!, assetPath: _asset(syllable.syllable, t));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tones = context.toneColors;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(syllable.syllable, style: theme.textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            Row(
              children: [
                for (var t = 1; t <= 4; t++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: _ToneButton(
                        label: syllableToMarked(syllable.syllable, t),
                        hanzi: syllable.tones[t],
                        color: tones.of(t),
                        selected: t == _selected,
                        onTap: syllable.tones[t] == null ? null : () => _play(t),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  final t = _selected;
                  Navigator.pop(context);
                  context.push(Routes.record(
                    hanzi: syllable.tones[t]!,
                    pinyin: syllableToMarked(syllable.syllable, t),
                  ));
                },
                icon: const Icon(Icons.mic_rounded),
                label: Text('${S.record} · ${syllableToMarked(syllable.syllable, _selected)}'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Quy ước file ghi âm sẵn (nếu có): assets/audio/pinyin/zhi4.mp3.
  static String _asset(String syllable, int tone) =>
      'assets/audio/pinyin/${syllable.replaceAll('ü', 'v')}$tone.mp3';
}

class _ToneButton extends StatelessWidget {
  const _ToneButton({
    required this.label,
    required this.hanzi,
    required this.color,
    required this.onTap,
    this.selected = false,
  });

  final String label;
  final String? hanzi;
  final Color color;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Opacity(
      opacity: enabled ? 1 : 0.3,
      child: Material(
        color: color.withValues(alpha: selected ? 0.22 : 0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: selected ? color : Colors.transparent, width: 2),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(children: [
              Text(label, style: TextStyle(
                  color: color, fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              HanziText(hanzi ?? '–', size: 18, serif: false),
            ]),
          ),
        ),
      ),
    );
  }
}
