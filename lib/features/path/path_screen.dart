import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../app/strings.dart';
import '../../app/theme/app_theme.dart';
import '../../core/utils/haptics.dart';
import '../../core/widgets/async_value_view.dart';
import '../../data/models/lesson.dart';
import 'path_providers.dart';

/// Tab "Học": lộ trình các bài dạng đường đi zíc-zắc cuộn dọc.
class PathScreen extends ConsumerWidget {
  const PathScreen({super.key});

  static const level = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = ref.watch(lessonPathProvider(level));
    return Scaffold(
      appBar: AppBar(title: const Text(S.learnTitle)),
      body: AsyncValueView(
        value: path,
        data: (nodes) {
          // Bài "hiện tại" = bài mở khoá đầu tiên chưa qua.
          final current = nodes.indexWhere((n) => n.unlocked && !n.passed);
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
            children: [
              const _PronunciationCard(),
              const SizedBox(height: 24),
              _PathView(nodes: nodes, current: current),
            ],
          );
        },
      ),
    );
  }
}

/// Vẽ các nút bài học lệch trái/phải theo hình sin, nối bằng đường nét đứt.
class _PathView extends StatelessWidget {
  const _PathView({required this.nodes, required this.current});

  final List<LessonNode> nodes;
  final int current;

  static const _rowHeight = 112.0;
  static const _nodeSize = 76.0;

  /// Độ lệch ngang (-1..1) của nút thứ i.
  static double _offset(int i) => sin(i * pi / 3);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final width = box.maxWidth;
        final amplitude = (width - _nodeSize) / 2 * 0.7;
        Offset center(int i) => Offset(
          width / 2 + _offset(i) * amplitude,
          i * _rowHeight + _nodeSize / 2,
        );

        return SizedBox(
          height: nodes.length * _rowHeight,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _PathPainter(
                    points: [for (var i = 0; i < nodes.length; i++) center(i)],
                    doneUntil: current < 0 ? nodes.length - 1 : current,
                    doneColor: Theme.of(context).colorScheme.primary,
                    todoColor: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
              ),
              for (var i = 0; i < nodes.length; i++)
                Positioned(
                  left: center(i).dx - _nodeSize / 2 - 30,
                  top: center(i).dy - _nodeSize / 2,
                  width: _nodeSize + 60,
                  child: _LessonNodeView(
                    node: nodes[i],
                    isCurrent: i == current,
                  ).animate().fadeIn(delay: (40 * i).ms).scaleXY(begin: 0.85),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _PathPainter extends CustomPainter {
  _PathPainter({
    required this.points,
    required this.doneUntil,
    required this.doneColor,
    required this.todoColor,
  });

  final List<Offset> points;
  final int doneUntil;
  final Color doneColor;
  final Color todoColor;

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i + 1 < points.length; i++) {
      final a = points[i], b = points[i + 1];
      final paint = Paint()
        ..color = i < doneUntil ? doneColor.withValues(alpha: 0.5) : todoColor
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round;
      // Nét đứt dọc theo đoạn thẳng nối hai nút.
      final total = (b - a).distance;
      final dir = (b - a) / total;
      for (var d = 0.0; d < total; d += 18) {
        canvas.drawLine(a + dir * d, a + dir * min(d + 8, total), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_PathPainter old) =>
      old.doneUntil != doneUntil || old.points.length != points.length;
}

class _LessonNodeView extends StatelessWidget {
  const _LessonNodeView({required this.node, required this.isCurrent});

  final LessonNode node;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final locked = !node.unlocked;
    final color = locked
        ? scheme.surfaceContainerHighest
        : node.passed
        ? AppColors.secondary
        : scheme.primary;

    Widget circle = Material(
      color: color,
      shape: const CircleBorder(),
      elevation: locked ? 0 : 3,
      shadowColor: color.withValues(alpha: 0.5),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          Haptics.tap();
          showModalBottomSheet<void>(
            context: context,
            showDragHandle: true,
            builder: (_) => _LessonSheet(node: node),
          );
        },
        child: SizedBox.square(
          dimension: _PathView._nodeSize,
          child: Center(
            child: locked
                ? Icon(Icons.lock_rounded, color: scheme.outline)
                : Text(
                    '${node.lesson.order}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
          ),
        ),
      ),
    );
    if (isCurrent) {
      // Nút bài hiện tại "thở" nhẹ để thu hút chú ý.
      circle = circle
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scaleXY(end: 1.07, duration: 900.ms, curve: Curves.easeInOut);
    }

    return Semantics(
      button: true,
      label: '${S.lessonNumber(node.lesson.order)}: ${node.lesson.title}',
      child: Column(
        children: [
          circle,
          const SizedBox(height: 4),
          if (node.stars > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              color: theme.scaffoldBackgroundColor,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var s = 0; s < 3; s++)
                    Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: s < node.stars
                          ? AppColors.secondary
                          : scheme.outlineVariant,
                    ),
                ],
              ),
            )
          else
            // Nền cùng màu trang để đường nối không cắt ngang chữ.
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Text(
                  node.lesson.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: locked ? scheme.outline : scheme.onSurface,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Bottom sheet giới thiệu bài: tiêu đề, số từ, điểm cao nhất, nút học.
class _LessonSheet extends StatelessWidget {
  const _LessonSheet({required this.node});

  final LessonNode node;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = node.lesson;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.lessonNumber(l.order),
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            Text(
              l.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            if (l.subtitle.isNotEmpty)
              Text(l.subtitle, style: theme.textTheme.bodyLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  avatar: const Icon(Icons.translate_rounded, size: 18),
                  label: Text(S.wordCount(node.wordCount)),
                ),
                if (node.bestScore > 0)
                  Chip(
                    avatar: const Icon(Icons.emoji_events_outlined, size: 18),
                    label: Text(S.bestScore(node.bestScore)),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: node.unlocked
                  ? FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        context.push(Routes.lesson(l.id));
                      },
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: Text(node.passed ? S.reviewLesson : S.startLesson),
                    )
                  : const FilledButton(
                      onPressed: null,
                      child: Text(S.lessonLocked),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Lối vào phần luyện phát âm (bảng pinyin, thanh điệu, ghi âm).
class _PronunciationCard extends StatelessWidget {
  const _PronunciationCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.primary,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: () => context.push(Routes.pronunciation),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: const CircleAvatar(
          backgroundColor: Colors.white24,
          child: Icon(Icons.record_voice_over_rounded, color: Colors.white),
        ),
        title: const Text(
          S.pronunciationTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        subtitle: const Text(
          S.pronunciationSubtitle,
          style: TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(Icons.arrow_forward_rounded, color: Colors.white),
      ),
    );
  }
}
