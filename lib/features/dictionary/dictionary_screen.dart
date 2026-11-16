import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../app/strings.dart';
import '../../core/utils/haptics.dart';
import '../../core/widgets/hanzi_text.dart';
import '../../core/widgets/pinyin_text.dart';
import '../../data/models/word.dart';
import '../../data/providers.dart';
import '../review/review_providers.dart';
import 'word_providers.dart';

/// Tab "Tra cứu": tìm theo chữ Hán, pinyin (có/không dấu, có số), tiếng Việt
/// (có/không dấu) hoặc Hán Việt. Hoàn toàn offline.
class DictionaryScreen extends ConsumerStatefulWidget {
  const DictionaryScreen({super.key});

  @override
  ConsumerState<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends ConsumerState<DictionaryScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final results = ref.watch(searchResultsProvider(_query));
    final loading = ref.watch(searchIndexProvider).isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text(S.dictionaryTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: TextField(
              controller: _controller,
              onChanged: (v) => setState(() => _query = v),
              textInputAction: TextInputAction.search,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: S.searchHint,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: S.clear,
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => setState(() {
                          _controller.clear();
                          _query = '';
                        }),
                      ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          if (_query.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(S.resultCount(results.length), style: theme.textTheme.labelMedium
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ),
            ),
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : results.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Text(S.noResults(_query), textAlign: TextAlign.center),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 24),
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: results.length,
                        itemBuilder: (_, i) => _ResultTile(word: results[i]),
                      ),
          ),
        ],
      ),
    );
  }
}

class _ResultTile extends ConsumerWidget {
  const _ResultTile({required this.word});

  final Word word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final inDeck = ref.watch(inDeckProvider(word.id)).value ?? false;
    return ListTile(
      onTap: () => context.push(Routes.word(word.id)),
      contentPadding: const EdgeInsets.only(left: 16, right: 4),
      leading: SizedBox(
        width: 72,
        child: HanziText(word.hanzi, size: 28, textAlign: TextAlign.center),
      ),
      title: PinyinText(word.pinyin, style: theme.textTheme.titleMedium
          ?.copyWith(fontWeight: FontWeight.w600)),
      subtitle: Text(word.meaningVi, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: IconButton(
        tooltip: inDeck ? S.inDeck : S.addToDeck,
        onPressed: inDeck
            ? null
            : () {
                Haptics.correct();
                ref.read(srsRepositoryProvider).addWordsForStudy([word]);
              },
        icon: Icon(
          inDeck ? Icons.check_circle_rounded : Icons.add_circle_outline_rounded,
          color: inDeck ? theme.colorScheme.primary : null,
        ),
      ),
    );
  }
}
