import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../app/strings.dart';
import '../../core/widgets/async_value_view.dart';
import '../../core/widgets/word_tile.dart';
import 'word_providers.dart';

/// Tab "Tra cứu". Sprint 0: danh sách toàn bộ từ HSK1.
/// Sprint 4 sẽ thêm ô tìm kiếm (chữ Hán / pinyin có-không dấu / tiếng Việt).
class DictionaryScreen extends ConsumerWidget {
  const DictionaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final words = ref.watch(wordsByLevelProvider(1));
    return Scaffold(
      appBar: AppBar(title: const Text(S.dictionaryTitle)),
      body: AsyncValueView(
        value: words,
        data: (items) => ListView.builder(
          padding: const EdgeInsets.only(bottom: 24),
          itemCount: items.length,
          itemBuilder: (_, i) => WordTile(
            word: items[i],
            onTap: () => context.push(Routes.word(items[i].id)),
          ),
        ),
      ),
    );
  }
}
