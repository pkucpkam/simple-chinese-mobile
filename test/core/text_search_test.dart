import 'package:flutter_test/flutter_test.dart';
import 'package:simple_chinese/core/utils/text_search.dart';

SearchEntry<String> e(String hanzi, String pinyin, String meaning, String hv) =>
    SearchEntry(value: hanzi, hanzi: hanzi, pinyin: pinyin, meaningVi: meaning, hanViet: hv);

void main() {
  final entries = [
    e('你', 'nǐ', 'bạn, anh, chị', 'nhĩ'),
    e('你好', 'nǐ hǎo', 'xin chào', 'nhĩ hảo'),
    e('好', 'hǎo', 'tốt, khỏe, hay', 'hảo'),
    e('谢谢', 'xiè xie', 'cảm ơn', 'tạ tạ'),
    e('老师', 'lǎo shī', 'giáo viên, thầy giáo, cô giáo', 'lão sư'),
    e('朋友', 'péng you', 'bạn bè, bạn', 'bằng hữu'),
    e('女儿', 'nǚ ér', 'con gái', 'nữ nhi'),
    e('电脑', 'diàn nǎo', 'máy tính', 'điện não'),
  ];

  test('foldVietnamese', () {
    expect(foldVietnamese('Cảm ơn'), 'cam on');
    expect(foldVietnamese('Điện  NÃO '), 'dien nao');
    expect(foldVietnamese('Trường học'), 'truong hoc');
  });

  test('phân loại truy vấn', () {
    expect(classifyQuery('你好'), QueryKind.hanzi);
    expect(classifyQuery('nǐ hǎo'), QueryKind.pinyinWithTones);
    expect(classifyQuery('ni3hao3'), QueryKind.pinyinWithTones);
    expect(classifyQuery('nihao'), QueryKind.latin);
    expect(classifyQuery('cảm ơn'), QueryKind.latin);
  });

  test('tìm theo chữ Hán: trùng khít trước, chứa sau', () {
    expect(searchEntries(entries, '好'), ['好', '你好']);
    expect(searchEntries(entries, '你'), ['你', '你好']);
  });

  test('tìm pinyin không dấu, có hoặc không dấu cách', () {
    expect(searchEntries(entries, 'nihao').first, '你好');
    expect(searchEntries(entries, 'ni hao').first, '你好');
    expect(searchEntries(entries, 'laoshi'), ['老师']);
    expect(searchEntries(entries, 'nuer'), ['女儿']);
  });

  test('tìm pinyin có dấu / có số: phân biệt thanh', () {
    expect(searchEntries(entries, 'nǐ hǎo'), ['你好']);
    expect(searchEntries(entries, 'ni3hao3'), ['你好']);
    expect(searchEntries(entries, 'nv3'), ['女儿']);
    expect(searchEntries(entries, 'ni2'), isEmpty);
  });

  test('tìm tiếng Việt có dấu hoặc không dấu', () {
    expect(searchEntries(entries, 'cảm ơn'), ['谢谢']);
    expect(searchEntries(entries, 'cam on'), ['谢谢']);
    expect(searchEntries(entries, 'may tinh'), ['电脑']);
    // "bạn": nghĩa trùng khít một mục được xếp trước
    expect(searchEntries(entries, 'bạn').take(2), containsAll(['你', '朋友']));
  });

  test('tìm theo Hán Việt', () {
    expect(searchEntries(entries, 'lão sư'), ['老师']);
  });

  test('truy vấn rỗng trả về tất cả theo thứ tự gốc', () {
    expect(searchEntries(entries, '  '), hasLength(entries.length));
  });
}
