import 'srs_card.dart';

/// Hoạt động một ngày (cho heatmap / biểu đồ).
class DayActivity {
  const DayActivity({required this.xp, required this.reviews, required this.minutes});

  final int xp;
  final int reviews;
  final int minutes;

  bool get active => xp > 0 || reviews > 0;
}

/// Độ chính xác một kỹ năng: số lượt ôn không bị "Again" / tổng lượt.
class SkillAccuracy {
  const SkillAccuracy({required this.correct, required this.total});

  final int correct;
  final int total;

  double get ratio => total == 0 ? 0 : correct / total;
}

class ProfileStats {
  const ProfileStats({
    required this.streak,
    required this.bestStreak,
    required this.totalXp,
    required this.todayXp,
    required this.totalMinutes,
    required this.wordsStudied,
    required this.days,
    required this.accuracy,
  });

  /// Chuỗi ngày học liên tiếp tính tới hôm nay (hoặc hôm qua nếu hôm nay
  /// chưa học — chuỗi chưa bị đứt cho tới hết ngày).
  final int streak;
  final int bestStreak;
  final int totalXp;
  final int todayXp;
  final int totalMinutes;

  /// Số từ đã học ít nhất một thẻ.
  final int wordsStudied;

  /// "yyyy-MM-dd" → hoạt động.
  final Map<String, DayActivity> days;
  final Map<CardSkill, SkillAccuracy> accuracy;
}

/// Tính chuỗi ngày hiện tại và dài nhất từ tập ngày có hoạt động.
/// [today] theo giờ địa phương. Hàm thuần để test.
(int current, int best) computeStreak(Set<DateTime> activeDays, DateTime today) {
  final days = activeDays.map((d) => DateTime(d.year, d.month, d.day)).toSet();
  final t = DateTime(today.year, today.month, today.day);

  // Dùng ngày lịch (cộng/trừ 1 ngày theo year-month-day) để không lệch khi
  // đổi giờ mùa hè.
  DateTime prev(DateTime d) => DateTime(d.year, d.month, d.day - 1);

  var start = days.contains(t) ? t : prev(t);
  var current = 0;
  while (days.contains(start)) {
    current++;
    start = prev(start);
  }

  var best = 0;
  for (final d in days) {
    if (days.contains(prev(d))) continue; // không phải đầu chuỗi
    var len = 0;
    var x = d;
    while (days.contains(x)) {
      len++;
      x = DateTime(x.year, x.month, x.day + 1);
    }
    if (len > best) best = len;
  }
  return (current, best);
}
