import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/srs_card.dart';
import '../../data/providers.dart';

part 'review_providers.g.dart';

@riverpod
Stream<DeckStats> deckStats(Ref ref) =>
    ref.watch(srsRepositoryProvider).watchStats();

@riverpod
Stream<bool> inDeck(Ref ref, String wordId) =>
    ref.watch(srsRepositoryProvider).watchInDeck(wordId);

/// Số thẻ mới tối đa mỗi ngày (chỉnh trong tab Tôi).
@Riverpod(keepAlive: true)
class DailyNewLimit extends _$DailyNewLimit {
  @override
  Future<int> build() => ref.watch(settingsRepositoryProvider).dailyNewLimit();

  Future<void> set(int value) async {
    state = AsyncData(value);
    await ref.read(settingsRepositoryProvider).setDailyNewLimit(value);
  }
}
