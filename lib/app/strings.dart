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

  // Phát âm
  static const pronunciationTitle = 'Luyện phát âm';
  static const pronunciationSubtitle = 'Bảng pinyin, thanh điệu, âm dễ nhầm, ghi âm';
  static const pinyinChart = 'Bảng pinyin';
  static const pinyinChartHint = 'Chạm vào ô để nghe 4 thanh';
  static const toneDrill = 'Nghe chọn thanh';
  static const toneDrillHint = 'Nghe một âm tiết, chọn thanh 1–4';
  static const tonePairDrill = 'Luyện cặp thanh';
  static const tonePairDrillHint = 'Nghe từ hai âm tiết, chọn đúng cặp thanh';
  static const confusables = 'Âm dễ nhầm';
  static const recordCompare = 'Ghi âm & so sánh';
  static const recordCompareHint = 'Đọc theo mẫu rồi nghe lại giọng mình';
  static const whichDidYouHear = 'Bạn nghe thấy âm nào?';
  static const whichTone = 'Thanh mấy?';
  static const whichTonePair = 'Cặp thanh nào?';
  static const showHanziHint = 'Không phát được âm — gợi ý chữ Hán:';
  static String questionOf(int i, int n) => 'Câu $i/$n';
  static String scoreOf(int c, int n) => 'Đúng $c/$n câu';
  static const practiceAgain = 'Luyện lại';
  static const sampleAudio = 'Nghe mẫu';
  static const myVoice = 'Giọng tôi';
  static const tapToRecord = 'Chạm để ghi âm';
  static const recording = 'Đang ghi… chạm để dừng';
  static const recordFailed =
      'Không thu được âm thanh. Hãy kiểm tra micro của máy rồi thử lại.';
  static const micButtonLabel = 'Nút ghi âm';
  static const micDenied = 'Cần quyền micro để ghi âm. Hãy cấp quyền trong Cài đặt.';
  static const recordTip =
      'Nghe mẫu, ghi âm giọng bạn, rồi nghe xen kẽ để so sánh thanh điệu.';
  static const record = 'Ghi âm';
  static const tone = 'Thanh';
  static const chooseToneOf = 'Chọn pinyin đúng cho từ';
  static const sandhiNote =
      'Lưu ý: hai thanh 3 đứng liền nhau, thanh 3 đầu đọc thành thanh 2 (nǐ hǎo → ní hǎo).';

  // Viết chữ
  static const writingTitle = 'Luyện viết';
  static const practiceWriting = 'Luyện viết';
  static const modeWatch = 'Xem';
  static const modeTrace = 'Tập tô';
  static const modeRecall = 'Viết';
  static const noStrokeData = 'Chưa có dữ liệu nét cho chữ này';
  static const writeFromMemory = 'Viết chữ Hán cho từ';
  static const traceHint = 'Tô theo chữ mờ, đúng thứ tự nét';
  static const recallHint = 'Viết từ trí nhớ — sai 3 lần sẽ có gợi ý';
  static const watchHint = 'Xem thứ tự nét, bấm ↻ để xem lại';
  static String writingScore(int s) => 'Điểm: $s/100';
  static const hint = 'Gợi ý';
  static const writeAgain = 'Viết lại';
  static String writingPadLabel(String c) => 'Khung viết chữ $c';
  static String charOf(int i, int n) => 'Chữ $i/$n';

  // Sắp xếp câu
  static const orderSentence = 'Sắp xếp thành câu đúng';
  static const clear = 'Xoá';

  // Bài học
  static const lessonLocked = 'Hoàn thành bài trước (≥ 80%) để mở khoá';
  static const startLesson = 'Bắt đầu học';
  static const reviewLesson = 'Học lại';
  static String bestScore(int s) => 'Điểm cao nhất: $s%';
  static const stepVocab = 'Từ mới';
  static const stepGrammar = 'Ngữ pháp';
  static const stepDialogue = 'Hội thoại';
  static const stepPractice = 'Luyện tập';
  static const stepQuiz = 'Kiểm tra';
  static const next = 'Tiếp';
  static const startQuiz = 'Làm bài kiểm tra';
  static const noGrammar = 'Bài này không có điểm ngữ pháp mới. Ôn lại mẫu câu trong hội thoại nhé!';
  static const quitLessonTitle = 'Thoát bài học?';
  static const quitLessonBody = 'Tiến độ của lần học này sẽ không được lưu.';
  static const lessonPassed = 'Qua bài!';
  static const lessonFailed = 'Chưa đạt';
  static String lessonScore(int s) => '$s%';
  static String needScore(int s) => 'Cần đạt từ $s% để qua bài';
  static const wordsAddedToDeck = 'Từ của bài đã được thêm vào bộ thẻ ôn tập';
  static const nextLessonUnlocked = 'Đã mở khoá bài tiếp theo!';
  static const retryQuiz = 'Làm lại bài kiểm tra';
  static const backToPath = 'Về lộ trình';
  static String xpGained(int xp) => '+$xp XP';

  // Nhắc học
  static const reminderChannelName = 'Nhắc học hằng ngày';
  static const reminderChannelDescription = 'Thông báo nhắc bạn ôn tập mỗi ngày';
  static const reminderTitle = 'Đến giờ học tiếng Trung rồi! 📚';
  static const reminderBody = 'Ôn vài thẻ để giữ chuỗi ngày học nhé.';
  static const reminder = 'Nhắc học hằng ngày';
  static String reminderAt(String t) => 'Lúc $t';
  static const notificationDenied =
      'Chưa được phép hiện thông báo. Hãy bật trong Cài đặt của máy.';

  // Hồ sơ
  static const streak = 'Chuỗi ngày';
  static String days(int n) => '$n ngày';
  static String bestStreak(int n) => 'Kỷ lục: $n ngày';
  static const totalXp = 'Tổng XP';
  static const wordsStudied = 'Từ đã học';
  static const activity = 'Hoạt động';
  static const last7Days = 'XP 7 ngày qua';
  static const accuracyBySkill = 'Độ chính xác theo kỹ năng';
  static const noReviewsYet = 'Chưa có lượt ôn nào';
  static const skillNames = {'read': 'Đọc', 'listen': 'Nghe', 'tone': 'Thanh điệu', 'write': 'Viết'};
  static String heatmapTooltip(String date, int xp, int reviews) => '$date · $xp XP · $reviews lượt ôn';
  static const less = 'Ít';
  static const more = 'Nhiều';
  static const weekdayShort = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];

  // Backup
  static const backup = 'Sao lưu';
  static const backupHint = 'Lưu tiến độ ra file JSON để chuyển máy hoặc phòng mất dữ liệu.';
  static const exportBackup = 'Xuất file';
  static const importBackup = 'Nhập file';
  static String exported(String name) => 'Đã lưu $name';
  static String imported(int n) => 'Đã khôi phục $n thẻ';
  static const importConfirmTitle = 'Khôi phục từ backup?';
  static const importConfirmBody =
      'Toàn bộ tiến độ hiện tại sẽ được thay bằng dữ liệu trong file. Không thể hoàn tác.';
  static const restore = 'Khôi phục';
  static const cancel = 'Huỷ';

  // Onboarding
  static const welcomeTitle = 'Chào mừng đến Simple Chinese';
  static const welcomeBody =
      'Học tiếng Trung HSK1 từ con số 0: phát âm, chữ Hán, từ vựng và hội thoại. '
      'Chạy hoàn toàn offline — dữ liệu chỉ nằm trên máy bạn.';
  static const goalTitle = 'Mục tiêu mỗi ngày';
  static const goalBody = 'Bạn muốn học bao nhiêu thẻ mới mỗi ngày? Có thể đổi sau trong tab Tôi.';
  static const goalOptions = {5: 'Nhẹ nhàng', 10: 'Vừa phải', 20: 'Chăm chỉ'};
  static String cardsPerDay(int n) => '$n thẻ mới / ngày';
  static const reminderTitleOnboarding = 'Nhắc học';
  static const reminderBodyOnboarding = 'Học đều mỗi ngày quan trọng hơn học nhiều một lúc.';
  static const pickTime = 'Chọn giờ';
  static const skip = 'Bỏ qua';
  static const getStarted = 'Bắt đầu học';

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
  static const searchHint = 'Chữ Hán, pinyin hoặc tiếng Việt';
  static String resultCount(int n) => '$n kết quả';
  static String noResults(String q) => 'Không tìm thấy "$q"';

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
