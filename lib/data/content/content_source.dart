import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'content_models.dart';

/// Nguồn đọc file nội dung. Tách thành interface để test importer
/// mà không cần asset bundle thật.
abstract interface class ContentSource {
  /// Danh sách thư mục cấp độ hiện có, vd ["hsk1", "hsk2"].
  Future<List<String>> listPacks();

  /// Đọc nội dung thô của một file; null nếu thư mục không có file đó.
  Future<String?> read(String pack, ContentKind kind);
}

/// Đọc từ assets. Tự phát hiện các thư mục `assets/content/<pack>/` nhờ
/// AssetManifest, nên thêm HSK2 chỉ cần thêm thư mục + 1 dòng khai báo
/// `- assets/content/hsk2/` trong pubspec.yaml (Flutter bắt buộc khai báo
/// từng thư mục asset), không phải sửa code Dart.
class AssetContentSource implements ContentSource {
  AssetContentSource([AssetBundle? bundle]) : _bundle = bundle ?? rootBundle;

  final AssetBundle _bundle;
  static const _root = 'assets/content/';
  static final _pattern = RegExp(r'^assets/content/([^/]+)/[^/]+\.json$');

  @override
  Future<List<String>> listPacks() async {
    final manifest = await AssetManifest.loadFromAssetBundle(_bundle);
    final packs = <String>{};
    for (final path in manifest.listAssets()) {
      final m = _pattern.firstMatch(path);
      if (m != null) packs.add(m.group(1)!);
    }
    return packs.toList()..sort();
  }

  @override
  Future<String?> read(String pack, ContentKind kind) async {
    try {
      return await _bundle.loadString('$_root$pack/${kind.fileName}');
    } on FlutterError {
      return null; // Thư mục không có file loại này.
    }
  }
}
