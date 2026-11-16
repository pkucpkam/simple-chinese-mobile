/// Tiện ích xử lý pinyin: đổi số → dấu thanh, dấu → số, bỏ dấu, tách âm tiết.
///
/// Quy ước trong app:
/// - Pinyin lưu trong nội dung ở dạng có dấu, các âm tiết cách nhau bằng dấu
///   cách: `"nǐ hǎo"`. Điều này giúp tô màu theo thanh điệu từng âm tiết.
/// - Thanh nhẹ là thanh 5 (chấp nhận cả `0` hoặc không có số khi nhập).
library;

/// Bảng nguyên âm có dấu, chỉ số 0..3 tương ứng thanh 1..4.
const Map<String, List<String>> _toneMarks = {
  'a': ['ā', 'á', 'ǎ', 'à'],
  'e': ['ē', 'é', 'ě', 'è'],
  'i': ['ī', 'í', 'ǐ', 'ì'],
  'o': ['ō', 'ó', 'ǒ', 'ò'],
  'u': ['ū', 'ú', 'ǔ', 'ù'],
  'ü': ['ǖ', 'ǘ', 'ǚ', 'ǜ'],
  'A': ['Ā', 'Á', 'Ǎ', 'À'],
  'E': ['Ē', 'É', 'Ě', 'È'],
  'I': ['Ī', 'Í', 'Ǐ', 'Ì'],
  'O': ['Ō', 'Ó', 'Ǒ', 'Ò'],
  'U': ['Ū', 'Ú', 'Ǔ', 'Ù'],
  'Ü': ['Ǖ', 'Ǘ', 'Ǚ', 'Ǜ'],
};

/// Bảng ngược: ký tự có dấu → (nguyên âm gốc, thanh 1..4).
final Map<String, (String, int)> _markToBase = {
  for (final e in _toneMarks.entries)
    for (var i = 0; i < e.value.length; i++) e.value[i]: (e.key, i + 1),
};

const _vowels = 'aeiouüAEIOUÜ';

/// Một âm tiết dạng số: phần chữ + số thanh tuỳ chọn ở cuối. `v` hoặc `u:` = ü.
final RegExp _numberedSyllable = RegExp(r'([a-zA-ZüÜ:]+)([0-5])?');

/// Đổi một âm tiết dạng số (`hao3`, `lv4`, `nu:3`, `ma5`, `ma`) sang dạng có dấu.
///
/// Quy tắc đặt dấu (chuẩn Hanyu Pinyin):
/// 1. Nếu có `a` hoặc `e` → đặt lên đó.
/// 2. Nếu có cụm `ou` → đặt lên `o`.
/// 3. Ngược lại đặt lên nguyên âm cuối cùng (vd `gui4` → `guì`, `liu2` → `liú`).
String syllableToMarked(String letters, int tone) {
  final s = letters.replaceAll('u:', 'ü').replaceAll('U:', 'Ü')
      .replaceAll('v', 'ü').replaceAll('V', 'Ü');
  if (tone < 1 || tone > 4) return s;

  int index = -1;
  final lower = s.toLowerCase();
  final aOrE = lower.indexOf(RegExp('[ae]'));
  if (aOrE >= 0) {
    index = aOrE;
  } else if (lower.contains('ou')) {
    index = lower.indexOf('ou');
  } else {
    for (var i = s.length - 1; i >= 0; i--) {
      if (_vowels.contains(s[i])) {
        index = i;
        break;
      }
    }
  }
  if (index < 0) return s; // Không có nguyên âm (vd "m", "ng" thán từ) → giữ nguyên.

  final marked = _toneMarks[s[index]]![tone - 1];
  return s.substring(0, index) + marked + s.substring(index + 1);
}

/// Đổi chuỗi pinyin dạng số sang có dấu: `"ni3 hao3"` → `"nǐ hǎo"`,
/// `"ni3hao3"` → `"nǐhǎo"`. Giữ nguyên dấu cách và dấu câu.
String numberedToMarked(String input) {
  return input.replaceAllMapped(_numberedSyllable, (m) {
    final tone = m.group(2) == null ? 5 : int.parse(m.group(2)!);
    return syllableToMarked(m.group(1)!, tone);
  });
}

/// Lấy thanh điệu (1..5) của một âm tiết có dấu. Không có dấu → 5 (thanh nhẹ).
int toneOfSyllable(String syllable) {
  for (final ch in syllable.split('')) {
    final hit = _markToBase[ch];
    if (hit != null) return hit.$2;
  }
  return 5;
}

/// Đổi một âm tiết có dấu sang dạng số. `ü` được viết thành `v` (cách gõ
/// phổ biến trên bàn phím). Thanh nhẹ trả về số 5.
String syllableToNumbered(String syllable) {
  final buffer = StringBuffer();
  var tone = 5;
  for (final ch in syllable.split('')) {
    final hit = _markToBase[ch];
    if (hit != null) {
      tone = hit.$2;
      buffer.write(hit.$1);
    } else {
      buffer.write(ch);
    }
  }
  final base = buffer.toString().replaceAll('ü', 'v').replaceAll('Ü', 'V');
  return '$base$tone';
}

/// Đổi chuỗi có dấu sang dạng số, giữ dấu cách: `"nǐ hǎo"` → `"ni3 hao3"`.
String markedToNumbered(String input) {
  return splitSyllables(input).map(syllableToNumbered).join(' ');
}

/// Bỏ toàn bộ dấu thanh, `ü` → `u`, chữ thường. Dùng cho tìm kiếm không dấu:
/// `"Nǚ'ér"` → `"nuer"` (khi [keepSpaces] = false).
String stripTones(String input, {bool keepSpaces = false}) {
  final buffer = StringBuffer();
  for (final ch in input.split('')) {
    final hit = _markToBase[ch];
    final base = hit?.$1 ?? ch;
    buffer.write(base);
  }
  var out = buffer.toString().toLowerCase().replaceAll('ü', 'u')
      .replaceAll('v', 'u').replaceAll(RegExp(r"[0-5'’]"), '');
  if (!keepSpaces) out = out.replaceAll(RegExp(r'\s+'), '');
  return out;
}

/// Tách chuỗi pinyin có dấu theo dấu cách / dấu nháy thành các âm tiết.
List<String> splitSyllables(String marked) => marked
    .split(RegExp(r"[\s'’]+"))
    .where((s) => s.isNotEmpty)
    .toList();

/// So sánh câu trả lời gõ pinyin số của người học với đáp án (có dấu).
/// Chấp nhận viết liền/cách, `v`/`u:`/`ü`, thanh nhẹ là 5, 0 hoặc bỏ trống.
bool numberedAnswerMatches(String answer, String expectedMarked) {
  String normalize(String s) => numberedToMarked(
        s.trim().toLowerCase().replaceAll('0', '5'),
      ).replaceAll(RegExp(r"[\s'’]+"), '');
  final expected = expectedMarked.toLowerCase().replaceAll(RegExp(r"[\s'’]+"), '');
  return normalize(answer) == expected;
}
