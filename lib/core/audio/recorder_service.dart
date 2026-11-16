import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recorder_service.g.dart';

/// Ghi âm giọng người học và phát lại. File ghi âm lưu trong thư mục tạm,
/// mỗi lần ghi đè lên file cũ (không cần lưu lâu dài).
class RecorderService {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  String? _lastPath;

  String? get lastPath => _lastPath;

  /// Hỏi quyền micro (hiện hộp thoại hệ thống lần đầu).
  Future<bool> ensurePermission() => _recorder.hasPermission();

  /// Bắt đầu ghi. Trả về luồng độ to (0..1) mỗi 60ms để vẽ dạng sóng.
  Future<Stream<double>> start() async {
    final dir = await getTemporaryDirectory();
    final path = p.join(dir.path, 'pronunciation_take.m4a');
    final file = File(path);
    if (await file.exists()) await file.delete();
    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        sampleRate: 22050,
        numChannels: 1,
        bitRate: 64000,
      ),
      path: path,
    );
    _lastPath = path;
    return _recorder
        .onAmplitudeChanged(const Duration(milliseconds: 60))
        .map((a) => normalizeDb(a.current));
  }

  /// true khi recorder đang ghi. Dùng để phát hiện recorder tự dừng
  /// (vd thiết bị không có micro / micro bị chiếm) mà UI chưa biết.
  Stream<bool> get recordingChanges =>
      _recorder.onStateChanged().map((s) => s == RecordState.record);

  Future<String?> stop() async {
    final path = await _recorder.stop();
    if (path != null) _lastPath = path;
    return path;
  }

  Future<void> playLast() async {
    final path = _lastPath;
    if (path == null || !await File(path).exists()) return;
    await _player.setFilePath(path);
    unawaited(_player.play());
  }

  Future<void> dispose() async {
    await _recorder.dispose();
    await _player.dispose();
  }

  /// Đổi dBFS (-160..0) sang thang 0..1 để vẽ. Dưới -50 dB coi như im lặng.
  static double normalizeDb(double db) {
    if (db.isNaN || db.isInfinite) return 0;
    return max(0, min(1, (db + 50) / 50));
  }
}

@riverpod
RecorderService recorderService(Ref ref) {
  final service = RecorderService();
  ref.onDispose(service.dispose);
  return service;
}
