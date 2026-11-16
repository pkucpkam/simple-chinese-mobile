import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/pronunciation.dart';
import '../../data/providers.dart';

part 'pronunciation_providers.g.dart';

@Riverpod(keepAlive: true)
Future<PinyinChart> pinyinChart(Ref ref) =>
    ref.watch(pronunciationRepositoryProvider).chart();

@Riverpod(keepAlive: true)
Future<PronunciationDrills> pronunciationDrills(Ref ref) =>
    ref.watch(pronunciationRepositoryProvider).drills();
