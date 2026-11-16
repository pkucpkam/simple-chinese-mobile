# Simple Chinese

App học tiếng Trung HSK cho người Việt. Chạy **offline hoàn toàn** — không backend,
mọi dữ liệu nằm trong SQLite (drift) trên máy.

## Chạy

```bash
flutter pub get
dart run build_runner build      # chỉ cần khi sửa model/provider/bảng DB
flutter run
flutter test
```

Code sinh tự động (`*.g.dart`, `*.freezed.dart`) được commit sẵn để clone về là chạy được.

## Kiến trúc

```
lib/
  app/            theme, router (go_router, 4 tab), chuỗi UI
  core/           widget dùng chung, pinyin utils, audio, haptics
  data/
    db/           Drift schema + migration
    content/      model nội dung + importer JSON → DB
    models/       domain model cho UI
    repositories/ lớp duy nhất UI được dùng để đọc/ghi dữ liệu
  features/       mỗi tính năng một thư mục (path, dictionary, review, profile, ...)
assets/
  content/hsk1/   words.json, lessons.json, grammar.json
  fonts/          Be Vietnam Pro, Noto Sans SC, Noto Serif SC (đã subset)
tool/             script tiện ích (subset font)
```

### Nội dung vs tiến độ

- **Nội dung** (words, lessons, grammar_points) là chỉ đọc, được import từ JSON lần đầu mở app.
- Mỗi file có `contentVersion`. Tăng số này → lần mở app sau sẽ import lại file đó.
- **Tiến độ** (cards, review_logs, lesson_progress, daily_stats, settings) không bao giờ bị
  importer đụng tới, và chỉ tham chiếu nội dung qua id chuỗi ổn định (`hsk1-001`), nên
  cập nhật nội dung không làm mất tiến độ.

### Thêm cấp độ mới (vd HSK2)

1. Tạo `assets/content/hsk2/` với `words.json` (+ `lessons.json`, `grammar.json`), `"level": 2`.
2. Thêm dòng `- assets/content/hsk2/` vào mục `assets` trong `pubspec.yaml`
   (Flutter bắt buộc khai báo từng thư mục asset). Không cần sửa code Dart.

### Quy ước pinyin trong nội dung

Pinyin có dấu, **tách từng âm tiết bằng dấu cách**: `"lǎo shī"`, `"nǐ shì lǎo shī ma?"`.
Nhờ vậy UI tô màu được theo thanh điệu từng âm tiết. Thanh điệu viết theo cách đọc
trong sách giáo khoa (`bú shì`, `yí ge`).

## Ôn tập (SRS)

- Lịch ôn theo FSRS (package `fsrs`), bọc trong `lib/data/srs/srs_scheduler.dart`.
- Mỗi từ thêm vào bộ thẻ tạo 3 thẻ: **đọc**, **nghe**, **thanh điệu**. Thẻ nghe/thanh
  chỉ mở từ ngày hôm sau khi đã học thẻ đọc, để không dồn nhiều thẻ của cùng một từ vào một ngày.
- Giới hạn thẻ mới mỗi ngày chỉnh trong tab Tôi (mặc định 10).
- Dạng bài chọn theo stability (`exercise_selector.dart`): thẻ mới → flashcard,
  yếu → trắc nghiệm nghĩa, trung bình → ghép cặp, mạnh → gõ pinyin; thẻ nghe →
  nghe chọn chữ; thẻ thanh → chọn pinyin đúng thanh. Chấm tự động: sai = Again, đúng nhưng > 8 giây = Hard, đúng nhanh = Good.
- Bản debug có mục **Công cụ dev** trong tab Tôi để tua thời gian, dùng để thử lịch ôn.

## Phát âm

- `assets/pronunciation/syllables.json`: bảng pinyin (392 âm tiết, ~1090 tổ hợp âm
  tiết + thanh), mỗi tổ hợp có một chữ Hán đại diện để TTS đọc đúng âm. Sinh bằng
  `tool/gen_pinyin_chart.py` từ Unicode Unihan (`kHanyuPinlu`, `kMandarin`, `kGB0`):
  chỉ lấy chữ giản thể thông dụng mà cách đọc đó chiếm ≥ 90% (tránh chữ đa âm).
- `assets/pronunciation/drills.json`: từ luyện cặp thanh và các nhóm âm dễ nhầm
  (z/zh, c/ch, s/sh, j/q/x, -n/-ng, ü/u).
- Audio ghi âm sẵn (nếu bổ sung sau) đặt theo quy ước `assets/audio/pinyin/zhi4.mp3`
  (`v` thay cho `ü`); app tự dùng file nếu có, không có thì đọc bằng TTS.
- Ghi âm & so sánh: ghi giọng người học (tối đa 5 giây), hiện dạng sóng, nghe xen kẽ
  với mẫu. Chưa chấm điểm thanh điệu tự động.

## Font

Font CJK gốc 18–25MB nên được subset về ASCII + Latin (pinyin) + 6763 chữ GB2312 bằng
`tool/subset_fonts.py`. Giấy phép OFL nằm trong `assets/fonts/`.
