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
  static const dismiss = 'Đóng';
  static const comingSoon = 'Sắp có';

  // Học
  static const learnTitle = 'Lộ trình HSK 1';
  static String lessonNumber(int n) => 'Bài $n';
  static String wordCount(int n) => '$n từ';

  // Ôn tập — màn chính
  static const reviewTitle = 'Ôn tập';
  static const dueNow = 'Cần ôn';
  static const newToday = 'Thẻ mới';
  static const reviewsToday = 'Đã ôn hôm nay';
  static String newOfLimit(int available, int limit) => '$available / $limit';
  static const startFlashcards = 'Flashcard';
  static const startFlashcardsHint = 'Lật thẻ, tự đánh giá';
  static const startMixed = 'Ôn tập hỗn hợp';
  static const startMixedHint = 'Trắc nghiệm, nghe, ghép cặp, gõ pinyin';
  static const deckEmptyTitle = 'Bộ thẻ đang trống';
  static const deckEmptyBody =
      'Vào tab Học hoặc Tra cứu, mở một từ và bấm "Thêm vào bộ thẻ".';
  static const allDoneTitle = 'Xong hết rồi!';
  static const allDoneBody = 'Không còn thẻ nào cần ôn lúc này. Quay lại sau nhé.';
  static String totalCards(int n) => 'Bộ thẻ: $n thẻ';

  // Bộ thẻ
  static const addToDeck = 'Thêm vào bộ thẻ';
  static const inDeck = 'Đã có trong bộ thẻ';
  static const addLessonToDeck = 'Thêm cả bài vào bộ thẻ';
  static const addedToDeck = 'Đã thêm vào bộ thẻ';

  // Flashcard
  static const tapToFlip = 'Chạm để lật thẻ';
  static const flip = 'Lật thẻ';
  static const listenAndRecall = 'Nghe và nhớ lại từ';
  static const swipeForgot = 'QUÊN';
  static const swipeRemembered = 'NHỚ';
  static const swipeHint = 'Vuốt trái = quên · Vuốt phải = nhớ';
  static const ratingAgain = 'Lại';
  static const ratingHard = 'Khó';
  static const ratingGood = 'Được';
  static const ratingEasy = 'Dễ';
  static const newBadge = 'MỚI';

  // Bài tập
  static const chooseMeaning = 'Chọn nghĩa đúng';
  static const listenChooseHanzi = 'Nghe và chọn chữ đúng';
  static const typePinyinPrompt = 'Gõ pinyin có số thanh';
  static const typePinyinHint = 'vd: ni3 hao3';
  static const check = 'Kiểm tra';
  static const matchPairs = 'Ghép chữ Hán với nghĩa';
  static String secondsLeft(int s) => '${s}s';
  static const correct = 'Chính xác!';
  static const wrong = 'Chưa đúng';
  static const slowButCorrect = 'Đúng rồi, nhưng hơi chậm';
  static const timeUp = 'Hết giờ!';
  static const continueLabel = 'Tiếp tục';
  static const showPinyinHint = 'Hiện pinyin';
  static const replay = 'Nghe lại';

  // Kết thúc phiên
  static const sessionDone = 'Hoàn thành phiên ôn!';
  static const answered = 'Lượt trả lời';
  static const accuracy = 'Độ chính xác';
  static const xpEarned = 'XP nhận được';
  static const done = 'Xong';
  static const quitSessionTitle = 'Dừng phiên ôn?';
  static const quitSessionBody = 'Các thẻ đã trả lời vẫn được lưu.';
  static const quit = 'Dừng';
  static const stay = 'Học tiếp';

  // Cài đặt học
  static const studySettings = 'Học tập';
  static const dailyNewLimit = 'Thẻ mới mỗi ngày';

  // Công cụ debug (không có trong bản release)
  static const devTools = 'Công cụ dev (debug)';
  static String clockOffset(String v) => 'Lệch giờ: $v';
  static const plus1Hour = '+1 giờ';
  static const plus1Day = '+1 ngày';
  static const plus10Days = '+10 ngày';
  static const resetClock = 'Về giờ thật';

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
