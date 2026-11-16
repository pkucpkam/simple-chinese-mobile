import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Dữ liệu nét chữ (Make Me a Hanzi) trong `assets/strokes/<mã hex>.json`.
class StrokeRepository {
  StrokeRepository([AssetBundle? bundle]) : _bundle = bundle ?? rootBundle;

  final AssetBundle _bundle;
  final Map<String, String?> _cache = {};

  static String assetFor(String char) =>
      'assets/strokes/${char.runes.first.toRadixString(16)}.json';

  /// JSON nét chữ của một chữ Hán, null nếu không có dữ liệu.
  Future<String?> strokeJson(String char) async {
    if (_cache.containsKey(char)) return _cache[char];
    String? json;
    try {
      json = await _bundle.loadString(assetFor(char));
    } on FlutterError {
      json = null; // Không có file → chữ chưa có dữ liệu nét.
    }
    return _cache[char] = json;
  }
}
