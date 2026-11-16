import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../app/strings.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/utils/dates.dart';
import '../../../data/models/profile_stats.dart';
import '../../../data/models/srs_card.dart';

/// Ba con số chính: chuỗi ngày, tổng XP, số từ đã học.
class StatsHeader extends StatelessWidget {
  const StatsHeader({super.key, required this.stats});

  final ProfileStats stats;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget tile(
      IconData icon,
      Color color,
      String value,
      String label, [
      String? sub,
    ]) => Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 6),
              Text(
                value,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(label, style: theme.textTheme.bodySmall),
              if (sub != null)
                Text(
                  sub,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    // IntrinsicHeight + stretch: 3 thẻ cao bằng nhau dù thẻ đầu có thêm dòng.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          tile(
            Icons.local_fire_department_rounded,
            AppColors.primary,
            S.days(stats.streak),
            S.streak,
            S.bestStreak(stats.bestStreak),
          ),
          const SizedBox(width: 8),
          tile(
            Icons.bolt_rounded,
            AppColors.secondary,
            '${stats.totalXp}',
            S.totalXp,
          ),
          const SizedBox(width: 8),
          tile(
            Icons.translate_rounded,
            theme.colorScheme.primary,
            '${stats.wordsStudied}',
            S.wordsStudied,
          ),
        ],
      ),
    );
  }
}

/// Heatmap hoạt động kiểu GitHub: cột = tuần, hàng = thứ (T2→CN). Màu tuần
/// tự một sắc độ: càng nhiều XP càng đậm. Chạm vào ô để xem chi tiết.
class ActivityHeatmap extends StatelessWidget {
  const ActivityHeatmap({
    super.key,
    required this.days,
    required this.today,
    this.weeks = 18,
  });

  final Map<String, DayActivity> days;
  final DateTime today;
  final int weeks;

  /// Ngưỡng XP cho 4 mức đậm.
  static const levels = [1, 20, 50, 100];

  static int levelOf(int xp) =>
      levels.lastIndexWhere((t) => xp >= t) + 1; // 0..4

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    Color colorOf(int level) => level == 0
        ? scheme.surfaceContainerHighest
        // Cùng một sắc độ (màu chủ đạo), tăng dần độ đậm — đọc được ở cả
        // nền sáng lẫn tối vì pha trên nền ô trống.
        : Color.alphaBlend(
            AppColors.primary.withValues(
              alpha: [0.25, 0.5, 0.75, 1.0][level - 1],
            ),
            scheme.surfaceContainerHighest,
          );

    // Cột cuối là tuần chứa hôm nay; hàng 0 = thứ Hai.
    final t = DateTime(today.year, today.month, today.day);
    final lastMonday = DateTime(t.year, t.month, t.day - (t.weekday - 1));
    final firstMonday = DateTime(
      lastMonday.year,
      lastMonday.month,
      lastMonday.day - 7 * (weeks - 1),
    );

    return LayoutBuilder(
      builder: (context, box) {
        const labelW = 24.0, gap = 3.0;
        final cell = ((box.maxWidth - labelW) / weeks - gap).clamp(6.0, 18.0);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: labelW,
                  child: Column(
                    children: [
                      for (var r = 0; r < 7; r++)
                        SizedBox(
                          height: cell + gap,
                          child: r.isEven
                              ? Text(
                                  S.weekdayShort[r],
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    fontSize: 9,
                                    color: scheme.onSurfaceVariant,
                                  ),
                                )
                              : null,
                        ),
                    ],
                  ),
                ),
                for (var w = 0; w < weeks; w++)
                  Padding(
                    padding: const EdgeInsets.only(right: gap),
                    child: Column(
                      children: [
                        for (var r = 0; r < 7; r++)
                          Builder(
                            builder: (_) {
                              final day = DateTime(
                                firstMonday.year,
                                firstMonday.month,
                                firstMonday.day + w * 7 + r,
                              );
                              // Ngày tương lai: chừa chỗ trống đúng kích thước ô (rộng = cell,
                              // cao = cell + gap) để cột không rộng hơn các cột khác.
                              if (day.isAfter(t)) {
                                return SizedBox(width: cell, height: cell + gap);
                              }
                              final a = days[dayKey(day)];
                              final level = levelOf(a?.xp ?? 0);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: gap),
                                child: Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  message: S.heatmapTooltip(
                                    '${day.day}/${day.month}',
                                    a?.xp ?? 0,
                                    a?.reviews ?? 0,
                                  ),
                                  child: Container(
                                    width: cell,
                                    height: cell,
                                    decoration: BoxDecoration(
                                      color: colorOf(level),
                                      borderRadius: BorderRadius.circular(3),
                                      border: day == t
                                          ? Border.all(
                                              color: scheme.onSurface,
                                              width: 1.2,
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            // Chú giải thang màu
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(S.less, style: theme.textTheme.labelSmall),
                const SizedBox(width: 4),
                for (var l = 0; l <= 4; l++)
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    decoration: BoxDecoration(
                      color: colorOf(l),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                const SizedBox(width: 4),
                Text(S.more, style: theme.textTheme.labelSmall),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// XP 7 ngày gần nhất: một chuỗi số liệu → một màu, không cần chú giải.
class WeeklyXpChart extends StatelessWidget {
  const WeeklyXpChart({super.key, required this.days, required this.today});

  final Map<String, DayActivity> days;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final dates = [
      for (var i = 6; i >= 0; i--)
        DateTime(today.year, today.month, today.day - i),
    ];
    final values = [
      for (final d in dates) (days[dayKey(d)]?.xp ?? 0).toDouble(),
    ];
    final maxY = values.fold<double>(0, (a, b) => a > b ? a : b);
    final labelStyle = theme.textTheme.labelSmall?.copyWith(
      color: scheme.onSurfaceVariant,
    );

    return SizedBox(
      height: 160,
      child: BarChart(
        BarChartData(
          maxY: maxY == 0 ? 10 : maxY * 1.2,
          alignment: BarChartAlignment.spaceAround,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) => FlLine(
              color: scheme.outlineVariant.withValues(alpha: 0.4),
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (v, meta) => v == meta.max
                    ? const SizedBox()
                    : Text(v.toInt().toString(), style: labelStyle),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) {
                  final d = dates[v.toInt()];
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      S.weekdayShort[d.weekday - 1],
                      style: labelStyle,
                    ),
                  );
                },
              ),
            ),
          ),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => scheme.inverseSurface,
              getTooltipItem: (group, _, rod, _) => BarTooltipItem(
                '${dates[group.x].day}/${dates[group.x].month}\n${rod.toY.toInt()} XP',
                TextStyle(
                  color: scheme.onInverseSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          barGroups: [
            for (var i = 0; i < 7; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: values[i],
                    width: 14,
                    color: AppColors.secondary,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

/// Độ chính xác theo kỹ năng: thanh ngang cùng một màu, nhãn & số bằng màu chữ.
class SkillAccuracyBars extends StatelessWidget {
  const SkillAccuracyBars({super.key, required this.accuracy});

  final Map<CardSkill, SkillAccuracy> accuracy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (accuracy.isEmpty) return const Text(S.noReviewsYet);
    return Column(
      children: [
        for (final skill in CardSkill.values)
          if (accuracy[skill] case final a?)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SizedBox(width: 84, child: Text(S.skillNames[skill.name]!)),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: a.ratio,
                        minHeight: 10,
                        color: theme.colorScheme.primary,
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 84,
                    child: Text(
                      '${(a.ratio * 100).round()}% · ${a.total}',
                      textAlign: TextAlign.right,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
