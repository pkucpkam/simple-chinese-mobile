import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/strings.dart';
import 'audio_service.dart';

/// Chỉ báo "thiếu giọng đọc" một lần mỗi lần mở app, tránh làm phiền
/// (và tránh che các nút bên dưới) khi người học bấm nghe liên tục.
bool _warnedThisRun = false;

/// Phát âm một từ/câu; nếu máy không phát được thì báo người dùng (1 lần).
/// Trả về true nếu phát được.
Future<bool> playAudio(
  WidgetRef ref,
  BuildContext context, {
  required String text,
  String? assetPath,
}) async {
  final ok = await ref.read(audioServiceProvider).play(text: text, assetPath: assetPath);
  if (!ok && !_warnedThisRun && context.mounted) {
    _warnedThisRun = true;
    // Banner ở trên cùng thay vì SnackBar: SnackBar nằm dưới đáy sẽ che các
    // nút trả lời / Tiếp tục của bài tập.
    final messenger = ScaffoldMessenger.of(context);
    messenger.showMaterialBanner(MaterialBanner(
      leading: const Icon(Icons.volume_off_rounded),
      content: const Text(S.ttsUnavailable),
      actions: [
        TextButton(
          onPressed: messenger.hideCurrentMaterialBanner,
          child: const Text(S.dismiss),
        ),
      ],
    ));
    // Dùng messenger đã lấy sẵn (không dùng context): màn gọi hàm này có thể
    // đã bị huỷ sau 6 giây (vd chuyển sang bài tập khác).
    Future.delayed(const Duration(seconds: 6), messenger.hideCurrentMaterialBanner);
  }
  return ok;
}
