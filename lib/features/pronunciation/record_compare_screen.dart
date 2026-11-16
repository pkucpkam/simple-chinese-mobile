import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/strings.dart';
import '../../core/audio/play_audio.dart';
import '../../core/audio/recorder_service.dart';
import '../../core/utils/haptics.dart';
import '../../core/widgets/hanzi_text.dart';
import '../../core/widgets/pinyin_text.dart';

/// Ghi âm giọng người học rồi nghe xen kẽ với audio mẫu.
///
/// Chưa chấm điểm tự động (cần nhận dạng cao độ / thanh điệu offline — để
/// sau); hiện tại hiển thị dạng sóng độ to để người học thấy độ dài và nhịp
/// so với mẫu, rồi tự so sánh bằng tai.
class RecordCompareScreen extends ConsumerStatefulWidget {
  const RecordCompareScreen({
    super.key,
    required this.hanzi,
    required this.pinyin,
  });

  final String hanzi;
  final String pinyin;

  @override
  ConsumerState<RecordCompareScreen> createState() =>
      _RecordCompareScreenState();
}

class _RecordCompareScreenState extends ConsumerState<RecordCompareScreen> {
  static const maxDuration = Duration(seconds: 5);

  final List<double> _levels = [];
  StreamSubscription<double>? _sub;
  StreamSubscription<bool>? _stateSub;
  Timer? _autoStop;
  bool _recording = false;
  bool _hasTake = false;

  RecorderService get _rec => ref.read(recorderServiceProvider);

  @override
  void dispose() {
    _sub?.cancel();
    _stateSub?.cancel();
    _autoStop?.cancel();
    super.dispose();
  }

  Future<void> _toggle() async {
    Haptics.tap();
    if (_recording) return _stop();
    if (!await _rec.ensurePermission()) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text(S.micDenied)));
      }
      return;
    }
    final stream = await _rec.start();
    setState(() {
      _recording = true;
      _levels.clear();
    });
    _sub = stream.listen((v) => setState(() => _levels.add(v)));
    // Recorder có thể tự dừng (máy không có micro, micro bị app khác chiếm):
    // khi đó dừng UI ngay thay vì báo "Đang ghi" tới hết giờ.
    _stateSub = _rec.recordingChanges.listen((recording) {
      if (!recording && _recording) _stop();
    });
    _autoStop = Timer(maxDuration, _stop);
  }

  Future<void> _stop() async {
    if (!_recording) return;
    _autoStop?.cancel();
    await _stateSub?.cancel();
    await _sub?.cancel();
    await _rec.stop();
    if (!mounted) return;
    // Có dữ liệu độ to và không phải im lặng hoàn toàn → coi là ghi được.
    final captured = _levels.length >= 3 && _levels.any((v) => v > 0.05);
    setState(() {
      _recording = false;
      _hasTake = captured;
    });
    if (!captured) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(S.recordFailed)));
      return;
    }
    // Phát lại ngay để người học nghe giọng mình.
    if (_hasTake) await _rec.playLast();
  }

  @override
  Widget build(BuildContext context) {
    // watch (không chỉ read): provider là autoDispose, cần giữ service sống
    // suốt thời gian màn hình mở, nếu không recorder bị huỷ ngay sau khi tạo.
    ref.watch(recorderServiceProvider);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text(S.recordCompare)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              child: Column(
                children: [
                  HanziText(widget.hanzi, size: 72),
                  const SizedBox(height: 4),
                  PinyinText(
                    widget.pinyin,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            S.recordTip,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 96,
            child: _Waveform(
              levels: List.of(_levels),
              color: _recording ? scheme.primary : scheme.secondary,
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Semantics(
              button: true,
              label: S.micButtonLabel,
              child: GestureDetector(
                onTap: _toggle,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _recording ? scheme.error : scheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: (_recording ? scheme.error : scheme.primary)
                            .withValues(alpha: 0.35),
                        blurRadius: _recording ? 24 : 12,
                      ),
                    ],
                  ),
                  child: Icon(
                    _recording ? Icons.stop_rounded : Icons.mic_rounded,
                    size: 44,
                    color: Colors.white,
                  ),
                ),
              ),
            ).animate(target: _recording ? 1 : 0).scaleXY(end: 1.06),
          ),
          const SizedBox(height: 8),
          Text(
            _recording ? S.recording : S.tapToRecord,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: _recording
                      ? null
                      : () => playAudio(ref, context, text: widget.hanzi),
                  icon: const Icon(Icons.volume_up_rounded),
                  label: const Text(S.sampleAudio),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: _hasTake && !_recording ? _rec.playLast : null,
                  icon: const Icon(Icons.person_rounded),
                  label: const Text(S.myVoice),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Dạng sóng đơn giản: mỗi cột là độ to (0..1) của một khung 60ms.
class _Waveform extends StatelessWidget {
  const _Waveform({required this.levels, required this.color});

  final List<double> levels;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _WavePainter(
        levels,
        color,
        Theme.of(context).colorScheme.outlineVariant,
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  _WavePainter(this.levels, this.color, this.baseline);

  final List<double> levels;
  final Color color;
  final Color baseline;

  /// Số cột tối đa (5 giây / 60ms ≈ 84).
  static const maxBars = 84;

  @override
  void paint(Canvas canvas, Size size) {
    final mid = size.height / 2;
    canvas.drawLine(
      Offset(0, mid),
      Offset(size.width, mid),
      Paint()
        ..color = baseline
        ..strokeWidth = 1,
    );
    final barW = size.width / maxBars;
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = barW * 0.6;
    for (var i = 0; i < levels.length && i < maxBars; i++) {
      final h = (levels[i] * size.height / 2).clamp(1.5, size.height / 2);
      final x = i * barW + barW / 2;
      canvas.drawLine(Offset(x, mid - h), Offset(x, mid + h), paint);
    }
  }

  @override
  bool shouldRepaint(_WavePainter old) =>
      old.levels.length != levels.length || old.color != color;
}
