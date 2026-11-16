import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stroke_order_animator/stroke_order_animator.dart';

import '../../../app/strings.dart';
import '../../../core/utils/haptics.dart';
import '../../../data/providers.dart';
import 'mizige_grid.dart';

part 'writing_pad.g.dart';

/// Chế độ khung viết.
enum WritingMode {
  /// Xem animation thứ tự nét.
  watch,

  /// Tập tô: hiện chữ mờ phía dưới, gợi ý ngay khi sai 1 nét.
  trace,

  /// Viết từ trí nhớ: không có chữ mờ, gợi ý sau 3 lần sai.
  recall,
}

/// Kết quả viết một chữ.
class WritingResult {
  const WritingResult({required this.strokes, required this.mistakes});

  final int strokes;
  final int mistakes;

  /// Điểm 0–100: tỉ lệ nét đúng trên tổng số lần vẽ nét.
  int get score =>
      strokes == 0 ? 0 : (100 * strokes / (strokes + mistakes)).round();
}

@riverpod
Future<String?> strokeData(Ref ref, String char) =>
    ref.watch(strokeRepositoryProvider).strokeJson(char);

/// Khung viết một chữ Hán trên nền 米字格.
class WritingPad extends ConsumerWidget {
  const WritingPad({
    super.key,
    required this.char,
    required this.mode,
    this.onComplete,
    this.size = 300,
  });

  final String char;
  final WritingMode mode;
  final ValueChanged<WritingResult>? onComplete;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(strokeDataProvider(char));
    return Semantics(
      label: S.writingPadLabel(char),
      child: SizedBox.square(
        dimension: size,
        child: MizigeGrid(
          child: data.when(
            data: (json) => json == null
                ? const Center(
                    child: Text(S.noStrokeData, textAlign: TextAlign.center),
                  )
                // Key theo chữ + chế độ: đổi chế độ thì tạo controller mới.
                : _Pad(
                    key: ValueKey('$char-${mode.name}'),
                    json: json,
                    mode: mode,
                    size: size,
                    onComplete: onComplete,
                  ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('$e')),
          ),
        ),
      ),
    );
  }
}

class _Pad extends StatefulWidget {
  const _Pad({
    super.key,
    required this.json,
    required this.mode,
    required this.size,
    this.onComplete,
  });

  final String json;
  final WritingMode mode;
  final double size;
  final ValueChanged<WritingResult>? onComplete;

  @override
  State<_Pad> createState() => _PadState();
}

class _PadState extends State<_Pad> with TickerProviderStateMixin {
  StrokeOrderAnimationController? _c;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_c != null) return;
    final scheme = Theme.of(context).colorScheme;
    final watch = widget.mode == WritingMode.watch;
    final trace = widget.mode == WritingMode.trace;
    _c = StrokeOrderAnimationController(
      StrokeOrder(widget.json),
      this,
      strokeAnimationSpeed: 1.2,
      showOutline: watch,
      // Tập tô: chữ mờ làm nền để tô theo.
      showBackground: trace,
      backgroundColor: scheme.onSurface.withValues(alpha: 0.12),
      strokeColor: scheme.onSurface,
      outlineColor: scheme.onSurface.withValues(alpha: 0.4),
      brushColor: scheme.primary,
      brushWidth: 10,
      hintColor: scheme.secondary,
      hintAfterStrokes: trace ? 1 : 3,
      onWrongStrokeCallback: (_) => Haptics.wrong(),
      onCorrectStrokeCallback: (_) => Haptics.tap(),
      onQuizCompleteCallback: (summary) {
        Haptics.correct();
        widget.onComplete?.call(
          WritingResult(
            strokes: summary.nStrokes,
            mistakes: summary.nTotalMistakes,
          ),
        );
      },
    );
    if (watch) {
      _c!.startAnimation();
    } else {
      _c!.startQuiz();
    }
  }

  @override
  void dispose() {
    _c?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = _c!;
    return Stack(
      children: [
        StrokeOrderAnimator(c, size: Size.square(widget.size)),
        if (widget.mode == WritingMode.watch)
          Positioned(
            right: 4,
            bottom: 4,
            child: ListenableBuilder(
              listenable: c,
              builder: (_, _) => IconButton.filledTonal(
                tooltip: S.replay,
                onPressed: c.isAnimating
                    ? null
                    : () => c
                        ..reset()
                        ..startAnimation(),
                icon: const Icon(Icons.replay_rounded),
              ),
            ),
          ),
      ],
    );
  }
}
