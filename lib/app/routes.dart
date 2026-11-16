/// Đường dẫn route, tách riêng để màn hình không phải import router.
abstract final class Routes {
  static const learn = '/learn';
  static const review = '/review';
  static const dictionary = '/dictionary';
  static const me = '/me';

  static const wordPattern = '/word/:id';
  static String word(String id) => '/word/$id';
}
