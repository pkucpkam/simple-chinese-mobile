import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_service.g.dart';

/// Phát âm: ưu tiên file audio có sẵn trong assets, nếu không có (hoặc lỗi)
/// thì đọc bằng TTS tiếng Trung (zh-CN) của hệ điều hành.
class AudioService {
  AudioService();

  final AudioPlayer _player = AudioPlayer();
  final FlutterTts _tts = FlutterTts();
  bool _ttsReady = false;

  Future<void> _initTts() async {
    if (_ttsReady) return;
    await _tts.setLanguage('zh-CN');
    await _tts.setSpeechRate(0.4); // Chậm hơn mặc định cho người mới học.
    // Không chờ đọc xong, để nút bấm phản hồi ngay và bấm lại thì ngắt câu cũ.
    await _tts.awaitSpeakCompletion(false);
  }

  /// Phát [assetPath] nếu có, ngược lại đọc [text] bằng TTS.
  ///
  /// Trả về false khi không phát được (vd máy/emulator không có engine TTS
  /// hoặc chưa cài giọng tiếng Trung) để UI báo cho người dùng.
  Future<bool> play({required String text, String? assetPath}) async {
    await stop();
    if (assetPath != null && assetPath.isNotEmpty) {
      try {
        await _player.setAsset(assetPath);
        _player.play(); // Không await: play() chỉ hoàn tất khi phát xong.
        return true;
      } catch (e) {
        debugPrint('Audio asset lỗi ($assetPath), chuyển sang TTS: $e');
      }
    }
    try {
      await _initTts();
      // Android trả về false/0 khi không có engine hoặc thiếu gói giọng zh-CN.
      final available = await _tts.isLanguageAvailable('zh-CN');
      if (available != true) return false;
      _ttsReady = true;
      final result = await _tts.speak(text);
      return result == 1;
    } catch (e) {
      debugPrint('TTS lỗi: $e');
      return false;
    }
  }

  Future<void> stop() async {
    await _player.stop();
    if (_ttsReady) await _tts.stop();
  }

  Future<void> dispose() async {
    await _player.dispose();
    await _tts.stop();
  }
}

@Riverpod(keepAlive: true)
AudioService audioService(Ref ref) {
  final service = AudioService();
  ref.onDispose(service.dispose);
  return service;
}
