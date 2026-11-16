import '../pinyin/pinyin.dart';

/// Nguyên âm tiếng Việt có dấu → không dấu. Dart chưa có chuẩn hoá Unicode
/// (NFD) sẵn, nên dùng bảng tra trực tiếp.
const _vietGroups = {
  'a': 'àáảãạăằắẳẵặâầấẩẫậ',
  'e': 'èéẻẽẹêềếểễệ',
  'i': 'ìíỉĩị',
  'o': 'òóỏõọôồốổỗộơờớởỡợ',
  'u': 'ùúủũụưừứửữự',
  'y': 'ỳýỷỹỵ',
  'd': 'đ',
};

final Map<String, String> _vietMap = {
  for (final e in _vietGroups.entries)
    for (final ch in e.value.split('')) ch: e.key,
};

/// Chuẩn hoá chuỗi tiếng Việt để so khớp: chữ thường, bỏ dấu, `đ` → `d`,
/// gộp khoảng trắng. "Cảm ơn" → "cam on".
String foldVietnamese(String input) {
  final lower = input.toLowerCase();
  final buf = StringBuffer();
  for (final ch in lower.split('')) {
    buf.write(_vietMap[ch] ?? ch);
  }
  return buf.toString().replaceAll(RegExp(r'\s+'), ' ').trim();
}

final _cjk = RegExp(r'[㐀-鿿]');
final _toneMarked = RegExp('[āáǎàēéěèīíǐìōóǒòūúǔùǖǘǚǜ]');
final _toneNumber = RegExp(r'[a-zü:]+[0-5]', caseSensitive: false);

/// Loại truy vấn, để biết so khớp trường nào.
enum QueryKind { hanzi, pinyinWithTones, latin }

QueryKind classifyQuery(String q) {
  if (_cjk.hasMatch(q)) return QueryKind.hanzi;
  if (_toneMarked.hasMatch(q) || _toneNumber.hasMatch(q)) return QueryKind.pinyinWithTones;
  return QueryKind.latin; // pinyin không dấu hoặc tiếng Việt
}

/// Dữ liệu tối thiểu để tìm kiếm một từ.
class SearchEntry<T> {
  SearchEntry({
    required this.value,
    required this.hanzi,
    required String pinyin,
    required String meaningVi,
    required String hanViet,
  })  : pinyinPlain = stripTones(pinyin),
        pinyinNumbered = markedToNumbered(pinyin).replaceAll(' ', ''),
        meaningFolded = foldVietnamese(meaningVi),
        hanVietFolded = foldVietnamese(hanViet);

  final T value;
  final String hanzi;
  final String pinyinPlain; // "laoshi"
  final String pinyinNumbered; // "lao3shi1"
  final String meaningFolded;
  final String hanVietFolded;
}

/// Tìm và xếp hạng. Điểm càng nhỏ càng khớp tốt:
/// trùng khít < bắt đầu bằng < chứa. Ưu tiên pinyin trước nghĩa tiếng Việt
/// với truy vấn latin (người học hay gõ pinyin không dấu).
List<T> searchEntries<T>(List<SearchEntry<T>> entries, String rawQuery, {int limit = 100}) {
  final q = rawQuery.trim();
  if (q.isEmpty) return [for (final e in entries) e.value];

  final kind = classifyQuery(q);
  final scored = <(int, int, T)>[];
  for (final (i, e) in entries.indexed) {
    final score = switch (kind) {
      QueryKind.hanzi => _rank(e.hanzi, q),
      QueryKind.pinyinWithTones => _rank(e.pinyinNumbered, _numberedKey(q)),
      QueryKind.latin => _latinRank(e, q),
    };
    if (score != null) scored.add((score, i, e.value));
  }
  scored.sort((a, b) => a.$1 != b.$1 ? a.$1.compareTo(b.$1) : a.$2.compareTo(b.$2));
  return [for (final s in scored.take(limit)) s.$3];
}

/// Khoá so khớp dạng số liền: "nǐ hǎo" / "ni3 hao3" / "ni3hao3" → "ni3hao3".
String _numberedKey(String q) {
  final lower = q.toLowerCase();
  if (RegExp(r'\d').hasMatch(lower)) {
    // Đã là dạng số: chỉ cần thống nhất ü → v, thanh nhẹ 0 → 5, bỏ cách.
    return lower
        .replaceAll('u:', 'v')
        .replaceAll('ü', 'v')
        .replaceAll('0', '5')
        .replaceAll(RegExp(r'\s+'), '');
  }
  return markedToNumbered(lower).replaceAll(' ', '');
}

int? _rank(String field, String q) {
  if (field == q) return 0;
  if (field.startsWith(q)) return 1;
  if (field.contains(q)) return 3;
  return null;
}

int? _latinRank(SearchEntry e, String q) {
  final folded = foldVietnamese(q);
  final compact = folded.replaceAll(' ', '');
  final ranks = <int?>[
    _rank(e.pinyinPlain, compact),
    // Nghĩa: khớp nguyên từ (theo ranh giới) tốt hơn khớp một phần.
    _meaningRank(e.meaningFolded, folded),
    _rank(e.hanVietFolded, folded).let((r) => r == null ? null : r + 2),
  ].whereType<int>();
  return ranks.isEmpty ? null : ranks.reduce((a, b) => a < b ? a : b);
}

int? _meaningRank(String meaning, String q) {
  // Nghĩa có thể gồm nhiều mục "bạn, anh, chị" → xét từng mục.
  final parts = meaning.split(RegExp(r'[,;()]')).map((s) => s.trim());
  if (parts.any((p) => p == q)) return 1;
  if (RegExp('(^|\\s)${RegExp.escape(q)}(\\s|\$)').hasMatch(meaning)) return 2;
  if (meaning.contains(q)) return 4;
  return null;
}

extension _Let<T> on T {
  R let<R>(R Function(T) f) => f(this);
}
