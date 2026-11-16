import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/strings.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/audio/play_audio.dart';
import '../../../core/utils/haptics.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/hanzi_text.dart';
import '../../../core/widgets/pinyin_text.dart';
import '../../../data/srs/srs_scheduler.dart';
import '../../review/exercises/answer_feedback.dart';
import '../pronunciation_providers.dart';
import 'drill_builder.dart';

/// Màn luyện nghe chung cho: chọn thanh, cặp thanh, âm dễ nhầm.
class DrillScreen extends ConsumerStatefulWidget {
  const DrillScreen({super.key, required this.kind});

  final DrillKind kind;

  @override
  ConsumerState<DrillScreen> createState() => _DrillScreenState();
}

class _DrillScreenState extends ConsumerState<DrillScreen> {
  final _builder = DrillBuilder();
  List<DrillQuestion>? _questions;
  String? _title;
  String? _tip;
  int _index = 0;
  int _correct = 0;
  int? _picked;
  bool _audioFailed = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final chart = await ref.read(pinyinChartProvider.future);
      final drills = await ref.read(pronunciationDrillsProvider.future);
      final (title, tip, questions) = switch (widget.kind) {
        ToneDrill() => (S.toneDrill, null, _builder.tones(chart)),
        TonePairDrill() =>
          (S.tonePairDrill, S.sandhiNote, _builder.tonePairs(drills.tonePairs)),
        ConfusableDrill(:final groupId) => () {
            final g = drills.confusables.firstWhere((g) => g.id == groupId);
            return (g.title, g.tipVi, _builder.confusables(g, chart.hanziFor));
          }(),
      };
      setState(() {
        _title = title;
        _tip = tip;
        _questions = questions;
        _index = 0;
        _correct = 0;
        _picked = null;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => _play());
    } catch (e) {
      setState(() => _error = e);
    }
  }

  DrillQuestion? get _q =>
      _questions == null || _index >= _questions!.length ? null : _questions![_index];

  Future<void> _play() async {
    final q = _q;
    if (q == null || !mounted) return;
    final ok = await playAudio(ref, context, text: q.speak);
    if (!ok && mounted) setState(() => _audioFailed = true);
  }

  void _pick(int i) {
    if (_picked != null) return;
    final ok = i == _q!.answer;
    ok ? Haptics.correct() : Haptics.wrong();
    setState(() {
      _picked = i;
      if (ok) _correct++;
    });
  }

  void _next() {
    setState(() {
      _index++;
      _picked = null;
    });
    _play();
  }

  @override
  Widget build(BuildContext context) {
    final questions = _questions;
    return Scaffold(
      appBar: AppBar(title: Text(_title ?? '')),
      body: _error != null
          ? AsyncValueView<void>(value: AsyncError(_error!, StackTrace.empty), data: (_) => const SizedBox())
          : questions == null
              ? const Center(child: CircularProgressIndicator())
              : _q == null
                  ? _summary(questions.length)
                  : _question(_q!, questions.length),
    );
  }

  Widget _question(DrillQuestion q, int total) {
    final theme = Theme.of(context);
    final answered = _picked != null;
    final title = switch (widget.kind) {
      ToneDrill() => S.whichTone,
      TonePairDrill() => S.whichTonePair,
      ConfusableDrill() => S.whichDidYouHear,
    };
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            children: [
              Row(children: [
                Text(S.questionOf(_index + 1, total), style: theme.textTheme.labelLarge),
                const SizedBox(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(value: _index / total, minHeight: 8),
                  ),
                ),
              ]),
              if (_tip != null) ...[
                const SizedBox(height: 16),
                Card(
                  color: AppColors.secondary.withValues(alpha: 0.12),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(children: [
                      const Icon(Icons.lightbulb_outline_rounded, color: AppColors.secondary),
                      const SizedBox(width: 10),
                      Expanded(child: Text(_tip!, style: theme.textTheme.bodySmall)),
                    ]),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Text(title, textAlign: TextAlign.center, style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              Center(
                child: IconButton.filledTonal(
                  iconSize: 48,
                  padding: const EdgeInsets.all(22),
                  onPressed: _play,
                  icon: const Icon(Icons.volume_up_rounded),
                ),
              ),
              // Không phát được âm (máy thiếu TTS) → hiện chữ Hán làm gợi ý để
              // vẫn luyện được; sau khi trả lời luôn hiện để củng cố.
              if (_audioFailed || answered) ...[
                const SizedBox(height: 12),
                if (_audioFailed && !answered)
                  Text(S.showHanziHint, textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall),
                Center(child: HanziText(q.speak, size: 40)),
                if (answered && q.meaning != null)
                  Text(q.meaning!, textAlign: TextAlign.center),
              ],
              const SizedBox(height: 24),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.2,
                children: [
                  for (final (i, opt) in q.options.indexed)
                    _OptionButton(
                      label: opt,
                      state: !answered
                          ? _OptState.idle
                          : i == q.answer
                              ? _OptState.correct
                              : i == _picked
                                  ? _OptState.wrong
                                  : _OptState.dimmed,
                      onTap: () => _pick(i),
                    ).animate().fadeIn(delay: (50 * i).ms),
                ],
              ),
            ],
          ),
        ),
        if (answered)
          AnswerFeedback(
            rating: _picked == q.answer ? Rating.good : Rating.again,
            onContinue: _next,
          ),
      ],
    );
  }

  Widget _summary(int total) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.emoji_events_rounded, size: 72, color: AppColors.secondary)
              .animate()
              .scale(duration: 400.ms, curve: Curves.elasticOut),
          const SizedBox(height: 16),
          Text(S.scoreOf(_correct, total), style: theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          FilledButton(onPressed: _load, child: const Text(S.practiceAgain)),
          const SizedBox(height: 8),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text(S.done)),
        ]),
      ),
    );
  }
}

enum _OptState { idle, correct, wrong, dimmed }

class _OptionButton extends StatelessWidget {
  const _OptionButton({required this.label, required this.state, required this.onTap});

  final String label;
  final _OptState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = switch (state) {
      _OptState.correct => kCorrectColor,
      _OptState.wrong => theme.colorScheme.error,
      _ => theme.colorScheme.outlineVariant,
    };
    return AnimatedOpacity(
      opacity: state == _OptState.dimmed ? 0.45 : 1,
      duration: const Duration(milliseconds: 200),
      child: Material(
        color: state == _OptState.correct || state == _OptState.wrong
            ? color.withValues(alpha: 0.12)
            : theme.cardTheme.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: color, width: state == _OptState.idle ? 1 : 2),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: state == _OptState.idle ? onTap : null,
          child: Center(
            child: PinyinText(label, style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
