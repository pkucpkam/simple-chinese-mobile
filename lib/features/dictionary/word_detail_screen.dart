import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/strings.dart';
import '../../app/theme/app_theme.dart';
import '../../core/audio/play_audio.dart';
import '../../core/utils/haptics.dart';
import '../../core/widgets/async_value_view.dart';
import '../../core/widgets/hanzi_text.dart';
import '../../core/widgets/pinyin_text.dart';
import '../../data/content/content_models.dart';
import '../../data/models/word.dart';
import '../../data/providers.dart';
import '../review/review_providers.dart';
import 'word_providers.dart';

/// Màn Chi tiết từ: chữ Hán lớn, pinyin tô màu, Hán Việt, nghĩa, ví dụ.
class WordDetailScreen extends ConsumerWidget {
  const WordDetailScreen({super.key, required this.wordId});

  final String wordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final word = ref.watch(wordProvider(wordId));
    return Scaffold(
      appBar: AppBar(),
      body: AsyncValueView(
        value: word,
        data: (w) => w == null
            ? const Center(child: Text(S.wordNotFound))
            : _WordDetailBody(word: w),
      ),
    );
  }
}

class _WordDetailBody extends ConsumerStatefulWidget {
  const _WordDetailBody({required this.word});

  final Word word;

  @override
  ConsumerState<_WordDetailBody> createState() => _WordDetailBodyState();
}

class _WordDetailBodyState extends ConsumerState<_WordDetailBody> {
  bool _showPinyin = true;
  bool _showTranslation = true;

  Future<void> _play(String text, {String? asset}) async {
    Haptics.tap();
    await playAudio(ref, context, text: text, assetPath: asset);
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.word;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
      children: [
        // --- Thẻ chính
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              children: [
                HanziText(w.hanzi, size: w.hanzi.length > 2 ? 64 : 88)
                    .animate()
                    .fadeIn(duration: 250.ms)
                    .scale(begin: const Offset(0.92, 0.92)),
                const SizedBox(height: 8),
                PinyinText(
                  w.pinyin,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                FilledButton.tonalIcon(
                  onPressed: () => _play(w.hanzi, asset: w.audioPath),
                  icon: const Icon(Icons.volume_up_rounded),
                  label: const Text(S.play),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _AddToDeckButton(wordId: w.id),
        const SizedBox(height: 16),

        // --- Hán Việt + nghĩa
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LabelValue(
                  label: S.hanViet,
                  value: w.hanViet.toUpperCase(),
                  valueStyle: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                const Divider(height: 28),
                _LabelValue(
                  label: S.meaning,
                  value: w.meaningVi,
                  valueStyle: theme.textTheme.titleMedium,
                ),
                if (w.mustWrite) ...[
                  const SizedBox(height: 16),
                  Chip(
                    avatar: Icon(Icons.edit_rounded, size: 18, color: scheme.primary),
                    label: const Text(S.mustWrite),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // --- Ví dụ
        if (w.examples.isNotEmpty) ...[
          Row(
            children: [
              Text(S.examples, style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
              const Spacer(),
              FilterChip(
                label: const Text(S.showPinyin),
                selected: _showPinyin,
                onSelected: (v) => setState(() => _showPinyin = v),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text(S.showTranslation),
                selected: _showTranslation,
                onSelected: (v) => setState(() => _showTranslation = v),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final (i, e) in w.examples.indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ExampleCard(
                example: e,
                showPinyin: _showPinyin,
                showTranslation: _showTranslation,
                onPlay: () => _play(e.hanzi),
              ).animate().fadeIn(delay: (80 * i).ms).slideY(begin: 0.08),
            ),
        ],
      ],
    );
  }
}

class _LabelValue extends StatelessWidget {
  const _LabelValue({required this.label, required this.value, this.valueStyle});

  final String label;
  final String value;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelMedium
            ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(height: 4),
        Text(value, style: valueStyle),
      ],
    );
  }
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({
    required this.example,
    required this.showPinyin,
    required this.showTranslation,
    required this.onPlay,
  });

  final ExampleSentence example;
  final bool showPinyin;
  final bool showTranslation;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPlay,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HanziText(example.hanzi, size: 22, serif: false),
                    if (showPinyin) ...[
                      const SizedBox(height: 4),
                      PinyinText(example.pinyin, style: theme.textTheme.bodyMedium),
                    ],
                    if (showTranslation) ...[
                      const SizedBox(height: 6),
                      Text(
                        example.vi,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(Icons.volume_up_outlined, color: theme.colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddToDeckButton extends ConsumerWidget {
  const _AddToDeckButton({required this.wordId});

  final String wordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inDeck = ref.watch(inDeckProvider(wordId)).value ?? false;
    return SizedBox(
      width: double.infinity,
      child: inDeck
          ? OutlinedButton.icon(
              onPressed: null,
              icon: const Icon(Icons.check_rounded),
              label: const Text(S.inDeck),
            )
          : FilledButton.icon(
              onPressed: () async {
                Haptics.correct();
                await ref.read(srsRepositoryProvider).addWords([wordId]);
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text(S.addToDeck),
            ),
    );
  }
}
