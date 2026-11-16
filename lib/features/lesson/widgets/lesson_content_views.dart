import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/strings.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/audio/play_audio.dart';
import '../../../core/widgets/hanzi_text.dart';
import '../../../core/widgets/pinyin_text.dart';
import '../../../data/content/content_models.dart';
import '../../../data/models/lesson.dart';
import '../../../data/models/word.dart';

/// Bước 1 — Từ mới: lướt qua từng thẻ từ.
class VocabStep extends ConsumerStatefulWidget {
  const VocabStep({super.key, required this.words, required this.onDone});

  final List<Word> words;
  final VoidCallback onDone;

  @override
  ConsumerState<VocabStep> createState() => _VocabStepState();
}

class _VocabStepState extends ConsumerState<VocabStep> {
  final _page = PageController(viewportFraction: 0.88);
  int _index = 0;

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  void _play(Word w) => playAudio(ref, context, text: w.hanzi, assetPath: w.audioPath);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final last = _index == widget.words.length - 1;
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _page,
            itemCount: widget.words.length,
            onPageChanged: (i) {
              setState(() => _index = i);
              _play(widget.words[i]);
            },
            itemBuilder: (_, i) {
              final w = widget.words[i];
              final ex = w.examples.firstOrNull;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HanziText(w.hanzi, size: w.hanzi.length > 2 ? 64 : 88),
                        PinyinText(w.pinyin, style: theme.textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text(w.hanViet.toUpperCase(), style: theme.textTheme.labelLarge?.copyWith(
                            color: AppColors.secondary, fontWeight: FontWeight.w700, letterSpacing: 1)),
                        const SizedBox(height: 12),
                        Text(w.meaningVi, textAlign: TextAlign.center,
                            style: theme.textTheme.titleLarge),
                        if (ex != null) ...[
                          const SizedBox(height: 20),
                          HanziText(ex.hanzi, size: 20, serif: false, textAlign: TextAlign.center),
                          PinyinText(ex.pinyin, style: theme.textTheme.bodySmall,
                              textAlign: TextAlign.center),
                          Text(ex.vi, textAlign: TextAlign.center, style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                        ],
                        const SizedBox(height: 16),
                        Wrap(spacing: 8, alignment: WrapAlignment.center, children: [
                          IconButton.filledTonal(
                            onPressed: () => _play(w),
                            icon: const Icon(Icons.volume_up_rounded),
                          ),
                          if (w.mustWrite)
                            FilledButton.tonalIcon(
                              onPressed: () => context.push(Routes.write(w.id)),
                              icon: const Icon(Icons.edit_rounded),
                              label: const Text(S.practiceWriting),
                            ),
                        ]),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Row(children: [
            Text('${_index + 1}/${widget.words.length}', style: theme.textTheme.labelLarge),
            const Spacer(),
            FilledButton(
              onPressed: last
                  ? widget.onDone
                  : () => _page.nextPage(
                      duration: const Duration(milliseconds: 250), curve: Curves.easeOut),
              child: const Text(S.next),
            ),
          ]),
        ),
      ],
    );
  }
}

/// Bước 2 — Ngữ pháp.
class GrammarStep extends ConsumerWidget {
  const GrammarStep({super.key, required this.points, required this.onDone});

  final List<GrammarContent> points;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Column(children: [
      Expanded(
        child: points.isEmpty
            ? const Center(child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(S.noGrammar, textAlign: TextAlign.center)))
            : ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                children: [
                  for (final (i, g) in points.indexed)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(g.title, style: theme.textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(g.pattern, style: theme.textTheme.titleMedium
                                    ?.copyWith(color: theme.colorScheme.primary)),
                              ),
                              const SizedBox(height: 12),
                              Text(g.explanationVi, style: theme.textTheme.bodyLarge),
                              const SizedBox(height: 12),
                              for (final e in g.examples)
                                InkWell(
                                  onTap: () => playAudio(ref, context, text: e.hanzi),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        HanziText(e.hanzi, size: 20, serif: false),
                                        PinyinText(e.pinyin, style: theme.textTheme.bodySmall),
                                        Text(e.vi, style: theme.textTheme.bodySmall?.copyWith(
                                            color: theme.colorScheme.onSurfaceVariant)),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(delay: (100 * i).ms),
                    ),
                ],
              ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(onPressed: onDone, child: const Text(S.next)),
        ),
      ),
    ]);
  }
}

/// Bước 3 — Hội thoại dạng chat, bật/tắt pinyin và bản dịch.
class DialogueStep extends ConsumerStatefulWidget {
  const DialogueStep({super.key, required this.lines, required this.onDone});

  final List<DialogueLine> lines;
  final VoidCallback onDone;

  @override
  ConsumerState<DialogueStep> createState() => _DialogueStepState();
}

class _DialogueStepState extends ConsumerState<DialogueStep> {
  bool _pinyin = true;
  bool _translation = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final first = widget.lines.firstOrNull?.speaker;
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
        child: Row(children: [
          FilterChip(
            label: const Text(S.showPinyin),
            selected: _pinyin,
            onSelected: (v) => setState(() => _pinyin = v),
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text(S.showTranslation),
            selected: _translation,
            onSelected: (v) => setState(() => _translation = v),
          ),
        ]),
      ),
      Expanded(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          children: [
            for (final (i, line) in widget.lines.indexed)
              Builder(builder: (context) {
                final mine = line.speaker != first; // người thứ 2 bên phải
                final bubble = mine ? scheme.primary.withValues(alpha: 0.12) : theme.cardTheme.color;
                return Align(
                  alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.78),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: bubble,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20),
                            topRight: const Radius.circular(20),
                            bottomLeft: Radius.circular(mine ? 20 : 4),
                            bottomRight: Radius.circular(mine ? 4 : 20),
                          ),
                          side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.5)),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => playAudio(ref, context, text: line.hanzi),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: Column(
                              crossAxisAlignment:
                                  mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                Text(line.speaker, style: theme.textTheme.labelSmall
                                    ?.copyWith(color: scheme.onSurfaceVariant)),
                                HanziText(line.hanzi, size: 22, serif: false),
                                if (_pinyin) PinyinText(line.pinyin, style: theme.textTheme.bodySmall),
                                if (_translation)
                                  Text(line.vi, style: theme.textTheme.bodySmall
                                      ?.copyWith(color: scheme.onSurfaceVariant)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: (150 * i).ms).slideY(begin: 0.15);
              }),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(onPressed: widget.onDone, child: const Text(S.next)),
        ),
      ),
    ]);
  }
}
