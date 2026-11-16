import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/strings.dart';
import '../../core/widgets/async_value_view.dart';
import '../../core/widgets/hanzi_text.dart';
import '../../core/widgets/pinyin_text.dart';
import '../dictionary/word_providers.dart';
import 'widgets/writing_pad.dart';

/// Luyện viết một từ: chọn chữ, chọn chế độ Xem / Tập tô / Viết.
class WritingScreen extends ConsumerStatefulWidget {
  const WritingScreen({super.key, required this.wordId});

  final String wordId;

  @override
  ConsumerState<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends ConsumerState<WritingScreen> {
  int _charIndex = 0;
  WritingMode _mode = WritingMode.watch;
  WritingResult? _result;
  int _attempt = 0; // tăng để làm mới khung viết khi bấm "Viết lại"

  @override
  Widget build(BuildContext context) {
    final word = ref.watch(wordProvider(widget.wordId));
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text(S.writingTitle)),
      body: AsyncValueView(
        value: word,
        data: (w) {
          if (w == null) return const Center(child: Text(S.wordNotFound));
          final chars = w.chars;
          final char = chars[_charIndex.clamp(0, chars.length - 1)];
          // Không dùng ListView: cử chỉ cuộn dọc sẽ "cướp" nét vẽ dọc trong
          // khung viết. Khung viết tự co theo không gian còn lại.
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
            child: Column(
              children: [
                Center(
                  child: PinyinText(
                    w.pinyin,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                Center(
                  child: Text(w.meaningVi, style: theme.textTheme.bodyMedium),
                ),
                const SizedBox(height: 12),
                if (chars.length > 1)
                  Center(
                    child: Wrap(
                      spacing: 8,
                      children: [
                        for (final (i, c) in chars.indexed)
                          ChoiceChip(
                            label: HanziText(c, size: 22, serif: false),
                            selected: i == _charIndex,
                            onSelected: (_) => setState(() {
                              _charIndex = i;
                              _result = null;
                            }),
                          ),
                      ],
                    ),
                  ),
                const SizedBox(height: 12),
                SegmentedButton<WritingMode>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(
                      value: WritingMode.watch,
                      label: Text(S.modeWatch),
                      icon: Icon(Icons.play_circle_outline_rounded),
                    ),
                    ButtonSegment(
                      value: WritingMode.trace,
                      label: Text(S.modeTrace),
                      icon: Icon(Icons.gesture_rounded),
                    ),
                    ButtonSegment(
                      value: WritingMode.recall,
                      label: Text(S.modeRecall),
                      icon: Icon(Icons.edit_rounded),
                    ),
                  ],
                  selected: {_mode},
                  onSelectionChanged: (s) => setState(() {
                    _mode = s.first;
                    _result = null;
                  }),
                ),
                const SizedBox(height: 8),
                Text(
                  switch (_mode) {
                    WritingMode.watch => S.watchHint,
                    WritingMode.trace => S.traceHint,
                    WritingMode.recall => S.recallHint,
                  },
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: LayoutBuilder(
                    builder: (_, box) => Center(
                      child: WritingPad(
                        key: ValueKey('$char-$_mode-$_attempt'),
                        char: char,
                        mode: _mode,
                        size: min(
                          box.maxWidth,
                          box.maxHeight,
                        ).clamp(160.0, 360.0),
                        onComplete: (r) => setState(() => _result = r),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 88,
                  child: _result == null
                      ? null
                      : Column(
                          children: [
                            Text(
                              S.writingScore(_result!.score),
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () => setState(() {
                                _attempt++;
                                _result = null;
                              }),
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text(S.writeAgain),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
