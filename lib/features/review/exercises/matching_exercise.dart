import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../app/strings.dart';
import '../../../core/utils/haptics.dart';
import '../../../core/widgets/hanzi_text.dart';
import '../../../data/models/srs_card.dart';
import '../../../data/srs/srs_scheduler.dart';
import '../session/session_task.dart';
import 'answer_feedback.dart';
import 'exercise_callbacks.dart';

/// Ghép chữ Hán (cột trái) với nghĩa (cột phải), có đồng hồ đếm ngược.
///
/// Chấm từng thẻ ngay khi ghép đúng:
/// - từng bị chọn nhầm trong ván → Again;
/// - ngược lại dùng thời gian kể từ lần ghép đúng trước (quy tắc 8 giây).
/// Hết giờ: các cặp chưa ghép → Again.
class MatchingExercise extends StatefulWidget {
  const MatchingExercise({
    super.key,
    required this.task,
    required this.onGrade,
    required this.onContinue,
    this.secondsPerPair = 10,
  });

  final MatchingTask task;
  final GradeCallback onGrade;
  final VoidCallback onContinue;
  final int secondsPerPair;

  @override
  State<MatchingExercise> createState() => _MatchingExerciseState();
}

class _MatchingExerciseState extends State<MatchingExercise> {
  late final List<StudyItem> _left = widget.task.items;
  late final List<StudyItem> _right = List.of(widget.task.items)..shuffle(Random());
  late final int _totalSeconds = widget.secondsPerPair * _left.length;
  late int _secondsLeft = _totalSeconds;

  final _matched = <int>{}; // cardId
  final _mistaken = <int>{}; // cardId
  final _sinceLastMatch = Stopwatch()..start();
  int? _selLeft; // cardId
  int? _selRight; // cardId
  int? _flashWrong; // cardId vừa chọn sai (để tô đỏ thoáng qua)
  Timer? _timer;
  bool _over = false;
  bool _timedOut = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_over) return;
      setState(() => _secondsLeft--);
      if (_secondsLeft <= 0) _finish(timedOut: true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _tapLeft(int id) {
    if (_over || _matched.contains(id)) return;
    Haptics.tap();
    setState(() => _selLeft = id);
    _check();
  }

  void _tapRight(int id) {
    if (_over || _matched.contains(id)) return;
    Haptics.tap();
    setState(() => _selRight = id);
    _check();
  }

  void _check() {
    final l = _selLeft, r = _selRight;
    if (l == null || r == null) return;
    if (l == r) {
      Haptics.correct();
      final item = _left.firstWhere((i) => i.card.id == l);
      final rating = _mistaken.contains(l)
          ? Rating.again
          : SrsScheduler.ratingForAnswer(correct: true, elapsed: _sinceLastMatch.elapsed);
      widget.onGrade(item, rating, _sinceLastMatch.elapsed);
      _sinceLastMatch.reset();
      setState(() {
        _matched.add(l);
        _selLeft = _selRight = null;
      });
      if (_matched.length == _left.length) _finish();
    } else {
      Haptics.wrong();
      // Nhầm lẫn → cả hai thẻ liên quan đều tính là chưa thuộc.
      setState(() {
        _mistaken..add(l)..add(r);
        _flashWrong = r;
        _selLeft = _selRight = null;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) setState(() => _flashWrong = null);
      });
    }
  }

  void _finish({bool timedOut = false}) {
    if (_over) return;
    _timer?.cancel();
    if (timedOut) {
      for (final item in _left) {
        if (!_matched.contains(item.card.id)) {
          widget.onGrade(item, Rating.again, _sinceLastMatch.elapsed);
        }
      }
    }
    setState(() {
      _over = true;
      _timedOut = timedOut;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ratio = _secondsLeft / _totalSeconds;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            children: [
              Row(children: [
                Expanded(
                  child: Text(S.matchPairs, style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700)),
                ),
                Icon(Icons.timer_outlined, size: 18,
                    color: ratio < 0.3 ? theme.colorScheme.error : null),
                const SizedBox(width: 4),
                Text(S.secondsLeft(_secondsLeft.clamp(0, _totalSeconds))),
              ]),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: ratio.clamp(0, 1),
                  minHeight: 6,
                  color: ratio < 0.3 ? theme.colorScheme.error : null,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(children: [
                      for (final i in _left)
                        _PairTile(
                          selected: _selLeft == i.card.id,
                          matched: _matched.contains(i.card.id),
                          wrong: false,
                          onTap: () => _tapLeft(i.card.id),
                          child: HanziText(i.word.hanzi, size: 26, serif: false),
                        ),
                    ]),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(children: [
                      for (final i in _right)
                        _PairTile(
                          selected: _selRight == i.card.id,
                          matched: _matched.contains(i.card.id),
                          wrong: _flashWrong == i.card.id,
                          onTap: () => _tapRight(i.card.id),
                          child: Text(
                            i.word.meaningVi,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (_over)
          AnswerFeedback(
            rating: _timedOut || _mistaken.isNotEmpty ? Rating.again : Rating.good,
            title: _timedOut ? S.timeUp : null,
            onContinue: widget.onContinue,
          ),
      ],
    );
  }
}

class _PairTile extends StatelessWidget {
  const _PairTile({
    required this.child,
    required this.selected,
    required this.matched,
    required this.wrong,
    required this.onTap,
  });

  final Widget child;
  final bool selected;
  final bool matched;
  final bool wrong;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final border = wrong
        ? scheme.error
        : matched
            ? kCorrectColor
            : selected
                ? scheme.primary
                : scheme.outlineVariant;
    Widget tile = AnimatedOpacity(
      opacity: matched ? 0.35 : 1,
      duration: const Duration(milliseconds: 250),
      child: Material(
        color: selected
            ? scheme.primary.withValues(alpha: 0.1)
            : matched
                ? kCorrectColor.withValues(alpha: 0.1)
                : Theme.of(context).cardTheme.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: border, width: selected || wrong ? 2 : 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: matched ? null : onTap,
          child: SizedBox(
            height: 72,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
    if (wrong) tile = tile.animate().shakeX(hz: 5, amount: 4, duration: 300.ms);
    return Padding(padding: const EdgeInsets.only(bottom: 10), child: tile);
  }
}
