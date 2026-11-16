/// Chuỗi giao diện (không phải nội dung học — nội dung học nằm trong
/// assets/content). Gom một chỗ để dễ sửa / dịch sau này.
abstract final class S {
  static const appName = 'Simple Chinese';

  // Tabs
  static const tabLearn = 'Học';
  static const tabReview = 'Ôn tập';
  static const tabDictionary = 'Tra cứu';
  static const tabMe = 'Tôi';

  // Chung
  static const loadingContent = 'Đang chuẩn bị nội dung…';
  static const errorGeneric = 'Đã có lỗi xảy ra';
  static const retry = 'Thử lại';
  static const comingSoon = 'Sắp có';

  // Học
  static const learnTitle = 'Lộ trình HSK 1';
  static String lessonNumber(int n) => 'Bài $n';
  static String wordCount(int n) => '$n từ';

  // Ôn tập
  static const reviewTitle = 'Ôn tập';
  static const reviewComingSoon =
      'Flashcard và phiên ôn tập FSRS sẽ có ở Sprint 1.';

  // Tra cứu
  static const dictionaryTitle = 'Tra cứu';
  static const searchHint = 'Tìm chữ Hán, pinyin hoặc tiếng Việt';

  // Chi tiết từ
  static const hanViet = 'Hán Việt';
  static const meaning = 'Nghĩa';
  static const examples = 'Ví dụ';
  static const play = 'Phát âm';
  static const ttsUnavailable =
      'Máy chưa có giọng đọc tiếng Trung. Hãy cài Google Text-to-Speech '
      'và tải giọng "Tiếng Trung (Trung Quốc)".';
  static const mustWrite = 'Cần biết viết';
  static const wordNotFound = 'Không tìm thấy từ này';
  static const showPinyin = 'Pinyin';
  static const showTranslation = 'Dịch';

  // Tôi
  static const meTitle = 'Tôi';
  static const appearance = 'Giao diện';
  static const themeSystem = 'Tự động';
  static const themeLight = 'Sáng';
  static const themeDark = 'Tối';
  static const toneLegend = 'Màu thanh điệu';
  static const contentInfo = 'Nội dung';
  static String wordsInDb(int n) => '$n từ đã nạp';
  static const toneNames = ['Thanh 1', 'Thanh 2', 'Thanh 3', 'Thanh 4', 'Thanh nhẹ'];
}
