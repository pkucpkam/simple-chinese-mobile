import '../../../data/models/srs_card.dart';
import '../../../data/srs/srs_scheduler.dart';

/// Chấm một thẻ (bài ghép cặp gọi nhiều lần).
typedef GradeCallback = void Function(
  StudyItem item,
  Rating rating,
  Duration elapsed,
);
