import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_chinese/core/pinyin/pinyin.dart';

void main() {
  group('numberedToMarked', () {
    test('đổi cụm cơ bản', () {
      expect(numberedToMarked('ni3 hao3'), 'nǐ hǎo');
      expect(numberedToMarked('ni3hao3'), 'nǐhǎo');
      expect(numberedToMarked('lao3 shi1'), 'lǎo shī');
    });

    test('quy tắc a/e được ưu tiên', () {
      expect(numberedToMarked('hao3'), 'hǎo');
      expect(numberedToMarked('xie4'), 'xiè');
      expect(numberedToMarked('xue2'), 'xué');
      expect(numberedToMarked('zhuang1'), 'zhuāng');
    });

    test('cụm ou → dấu trên o', () {
      expect(numberedToMarked('dou1'), 'dōu');
      expect(numberedToMarked('zhou1'), 'zhōu');
    });

    test('còn lại → nguyên âm cuối (iu, ui)', () {
      expect(numberedToMarked('liu2'), 'liú');
      expect(numberedToMarked('gui4'), 'guì');
      expect(numberedToMarked('shui3'), 'shuǐ');
      expect(numberedToMarked('duo1'), 'duō');
    });

    test('ü viết bằng v hoặc u:', () {
      expect(numberedToMarked('nv3'), 'nǚ');
      expect(numberedToMarked('lu:4'), 'lǜ');
      expect(numberedToMarked('lve4'), 'lüè');
      expect(numberedToMarked('nü3'), 'nǚ');
    });

    test('thanh nhẹ 5/không số giữ nguyên', () {
      expect(numberedToMarked('ma5'), 'ma');
      expect(numberedToMarked('xie4 xie5'), 'xiè xie');
      expect(numberedToMarked('de'), 'de');
    });

    test('giữ chữ hoa và dấu câu', () {
      expect(numberedToMarked('Zhong1guo2'), 'Zhōngguó');
      expect(numberedToMarked('ni3 hao3!'), 'nǐ hǎo!');
      expect(numberedToMarked('er4'), 'èr');
    });
  });

  group('markedToNumbered / toneOfSyllable', () {
    test('đổi ngược', () {
      expect(markedToNumbered('nǐ hǎo'), 'ni3 hao3');
      expect(markedToNumbered('xiè xie'), 'xie4 xie5');
      expect(markedToNumbered('nǚ ér'), 'nv3 er2');
    });

    test('round-trip', () {
      for (final s in ['zhōng guó', 'lǎo shī', 'shén me', 'lǜ', 'péng you']) {
        expect(numberedToMarked(markedToNumbered(s)), s);
      }
    });

    test('lấy thanh điệu', () {
      expect(toneOfSyllable('mā'), 1);
      expect(toneOfSyllable('má'), 2);
      expect(toneOfSyllable('mǎ'), 3);
      expect(toneOfSyllable('mà'), 4);
      expect(toneOfSyllable('ma'), 5);
      expect(toneOfSyllable('nǚ'), 3);
      expect(toneOfSyllable('hǎo!'), 3);
    });
  });

  group('stripTones / splitSyllables', () {
    test('bỏ dấu cho tìm kiếm', () {
      expect(stripTones('nǐ hǎo'), 'nihao');
      expect(stripTones('Nǚ ér'), 'nuer');
      expect(stripTones('nǐ hǎo', keepSpaces: true), 'ni hao');
      expect(stripTones('ni3 hao3'), 'nihao');
    });

    test('tách âm tiết', () {
      expect(splitSyllables('lǎo shī'), ['lǎo', 'shī']);
      expect(splitSyllables("nǚ'ér"), ['nǚ', 'ér']);
      expect(splitSyllables('  a  b '), ['a', 'b']);
    });
  });

  group('numberedAnswerMatches', () {
    test('chấp nhận nhiều cách gõ', () {
      expect(numberedAnswerMatches('ni3 hao3', 'nǐ hǎo'), isTrue);
      expect(numberedAnswerMatches('ni3hao3', 'nǐ hǎo'), isTrue);
      expect(numberedAnswerMatches('NI3 HAO3', 'nǐ hǎo'), isTrue);
      expect(numberedAnswerMatches('nv3 er2', 'nǚ ér'), isTrue);
      expect(numberedAnswerMatches('xie4 xie0', 'xiè xie'), isTrue);
      expect(numberedAnswerMatches('xie4 xie', 'xiè xie'), isTrue);
    });

    test('sai thanh thì không khớp', () {
      expect(numberedAnswerMatches('ni2 hao3', 'nǐ hǎo'), isFalse);
      expect(numberedAnswerMatches('ni hao', 'nǐ hǎo'), isFalse);
    });
  });

  group('tonesOf / withTones / toneVariants', () {
    test('tonesOf', () {
      expect(tonesOf('lǎo shī'), [3, 1]);
      expect(tonesOf('xiè xie'), [4, 5]);
    });

    test('withTones đổi thanh, giữ chữ và dấu câu', () {
      expect(withTones('lǎo shī', [2, 4]), 'láo shì');
      expect(withTones('nǚ ér', [1, 3]), 'nǖ ěr');
      expect(withTones('hǎo!', [4]), 'hào!');
      expect(withTones('xiè xie', [1, 5]), 'xiē xie');
    });

    test('toneVariants: đủ số lượng, chứa đáp án, không trùng', () {
      for (var seed = 0; seed < 30; seed++) {
        final r = Random(seed);
        final v = toneVariants('lǎo shī', r.nextInt);
        expect(v, hasLength(4));
        expect(v, contains('lǎo shī'));
        expect(v.toSet(), hasLength(4));
        // Chữ cái giữ nguyên, chỉ thanh thay đổi.
        expect(v.map((s) => stripTones(s)).toSet(), {'laoshi'});
      }
    });

    test('toneVariants: 1 âm tiết → đủ 4 thanh', () {
      final v = toneVariants('mā', Random(1).nextInt);
      expect(v.toSet(), {'mā', 'má', 'mǎ', 'mà'});
    });

    test('toneVariants: giữ nguyên âm tiết thanh nhẹ', () {
      final v = toneVariants('mā ma', Random(2).nextInt);
      expect(v.every((s) => s.endsWith(' ma')), isTrue);
    });
  });
}
