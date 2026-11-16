/// Đường dẫn route, tách riêng để màn hình không phải import router.
abstract final class Routes {
  static const learn = '/learn';
  static const review = '/review';
  static const dictionary = '/dictionary';
  static const me = '/me';

  static const wordPattern = '/word/:id';

  static const sessionPattern = '/session/:mode';
  static String session(String mode) => '/session/$mode';
  static String word(String id) => '/word/$id';

  static const lessonPattern = '/lesson/:id';
  static String lesson(String id) => '/lesson/$id';
  static const writePattern = '/write/:id';
  static String write(String wordId) => '/write/$wordId';

  static const pronunciation = '/pronunciation';
  static const pinyinChart = '/pronunciation/chart';
  static const drillPattern = '/pronunciation/drill/:kind';
  static String drill(String kind) => '/pronunciation/drill/$kind';
  static const recordPath = '/pronunciation/record';
  static String record({required String hanzi, required String pinyin}) =>
      Uri(path: recordPath, queryParameters: {'hanzi': hanzi, 'pinyin': pinyin})
          .toString();
}
