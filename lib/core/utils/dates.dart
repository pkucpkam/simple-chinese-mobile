/// Khoá ngày địa phương "yyyy-MM-dd" (dùng cho daily_stats).
String dayKey(DateTime t) {
  final l = t.toLocal();
  String two(int n) => n.toString().padLeft(2, '0');
  return '${l.year}-${two(l.month)}-${two(l.day)}';
}

/// 0h hôm nay theo giờ địa phương.
DateTime startOfDay(DateTime t) {
  final l = t.toLocal();
  return DateTime(l.year, l.month, l.day);
}

/// Định dạng khoảng ôn ngắn gọn: "1 phút", "10 phút", "3 ngày", "2 tháng".
String formatInterval(Duration d) {
  if (d.inMinutes < 1) return '<1 phút';
  if (d.inHours < 1) return '${d.inMinutes} phút';
  if (d.inDays < 1) return '${d.inHours} giờ';
  if (d.inDays < 30) return '${d.inDays} ngày';
  if (d.inDays < 365) return '${(d.inDays / 30).round()} tháng';
  return '${(d.inDays / 365).toStringAsFixed(1)} năm';
}
