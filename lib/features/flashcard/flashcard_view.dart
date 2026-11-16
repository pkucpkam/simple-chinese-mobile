import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/strings.dart';
import '../../app/theme/app_theme.dart';
import '../../core/audio/play_audio.dart';
import '../../core/utils/clock.dart';
import '../../core/utils/dates.dart';
import '../../core/utils/haptics.dart';
import '../../core/widgets/hanzi_text.dart';
import '../../core/widgets/pinyin_text.dart';
import '../../data/models/srs_card.dart';
import '../../data/providers.dart';
import '../../data/srs/srs_scheduler.dart';
import 'widgets/flip_card.dart';
import 'widgets/swipe_card.dart';

/// Một thẻ flashcard: lật 3D, vuốt trái (quên) / phải (nhớ) hoặc bấm 4 nút
/// Again/Hard/Good/Easy kèm khoảng ôn kế tiếp.
class FlashcardView extends ConsumerStatefulWidget {
  const FlashcardView({super.key, required this.item, required this.onRated});

  final StudyItem item;

  /// Gọi khi người học đánh giá xong thẻ.
  final void Function(Rating rating, Duration elapsed) onRated;

  @override
  ConsumerState<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends ConsumerState<FlashcardView> {
  final _watch = Stopwatch()..start();
  bool _flipped = false;
  bool _rated = false;
  late final Map<Rating, Duration> _intervals = ref
      .read(srsRepositoryProvider)
      .scheduler
      .previewIntervals(widget.item.card, AppClock.now());

  bool get _isListen => widget.item.card.skill == CardSkill.listen;

  @override
  void initState() {
    super.initState();
    // Thẻ nghe: phát âm ngay khi hiện thẻ.
    if (_isListen) WidgetsBinding.instance.addPostFrameCallback((_) => _play());
  }

  Future<void> _play() async {
    final w = widget.item.word;
    await playAudio(ref, context, text: w.hanzi, assetPath: w.audioPath);
  }

  void _flip() {
    Haptics.tap();
    setState(() => _flipped = !_flipped);
    if (_flipped && !_isListen) _play();
  }

  void _rate(Rating r) {
    if (_rated) return;
    _rated = true;
    r == Rating.again ? Haptics.wrong() : Haptics.correct();
    widget.onRated(r, _watch.elapsed);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: SwipeCard(
              leftLabel: S.swipeForgot,
              rightLabel: S.swipeRemembered,
              leftColor: theme.colorScheme.error,
              rightColor: const Color(0xFF1F9D55),
              onSwiped: (d) =>
                  _rate(d == SwipeDirection.right ? Rating.good : Rating.again),
              child: FlipCard(
                flipped: _flipped,
                onTap: _flip,
                front: _Face(child: _front(theme)),
                back: _Face(child: _back(theme)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
          child: Text(
            S.swipeHint,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _flipped
                ? _RatingButtons(intervals: _intervals, onRate: _rate)
                : SizedBox(
                    width: double.infinity,
                    child: FilledButton(onPressed: _flip, child: const Text(S.flip)),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _front(ThemeData theme) {
    final w = widget.item.word;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.item.card.isNew)
          Chip(
            label: const Text(S.newBadge),
            backgroundColor: AppColors.secondary.withValues(alpha: 0.18),
            side: BorderSide.none,
          ),
        const Spacer(),
        if (_isListen) ...[
          IconButton.filledTonal(
            iconSize: 56,
            padding: const EdgeInsets.all(24),
            onPressed: _play,
            icon: const Icon(Icons.volume_up_rounded),
          ),
          const SizedBox(height: 16),
          Text(S.listenAndRecall, style: theme.textTheme.titleMedium),
        ] else
          HanziText(w.hanzi, size: w.hanzi.length > 2 ? 72 : 104),
        const Spacer(),
        Text(
          S.tapToFlip,
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _back(ThemeData theme) {
    final w = widget.item.word;
    final example = w.examples.isEmpty ? null : w.examples.first;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HanziText(w.hanzi, size: 64),
        const SizedBox(height: 8),
        PinyinText(w.pinyin, style: theme.textTheme.headlineSmall
            ?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(
          w.hanViet.toUpperCase(),
          style: theme.textTheme.labelLarge?.copyWith(
            color: AppColors.secondary,
            letterSpacing: 1,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          w.meaningVi,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge,
        ),
        if (example != null) ...[
          const SizedBox(height: 24),
          HanziText(example.hanzi, size: 20, serif: false, textAlign: TextAlign.center),
          PinyinText(example.pinyin, style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center),
          Text(example.vi, textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
        const SizedBox(height: 12),
        IconButton(onPressed: _play, icon: const Icon(Icons.volume_up_rounded)),
      ],
    );
  }
}

class _Face extends StatelessWidget {
  const _Face({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => SizedBox.expand(
        child: Card(
          child: Padding(padding: const EdgeInsets.all(24), child: child),
        ),
      );
}

class _RatingButtons extends StatelessWidget {
  const _RatingButtons({required this.intervals, required this.onRate});

  final Map<Rating, Duration> intervals;
  final ValueChanged<Rating> onRate;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final specs = [
      (Rating.again, S.ratingAgain, scheme.error),
      (Rating.hard, S.ratingHard, AppColors.secondary),
      (Rating.good, S.ratingGood, const Color(0xFF1F9D55)),
      (Rating.easy, S.ratingEasy, const Color(0xFF1E6FD9)),
    ];
    return Row(
      children: [
        for (final (rating, label, color) in specs)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: color.withValues(alpha: 0.14),
                  foregroundColor: color,
                  minimumSize: const Size(0, 60),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                ),
                onPressed: () => onRate(rating),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(label),
                    Text(
                      formatInterval(intervals[rating]!),
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
