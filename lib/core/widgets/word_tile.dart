import 'package:flutter/material.dart';

import '../../data/models/word.dart';
import 'hanzi_text.dart';
import 'pinyin_text.dart';

/// Một dòng từ vựng trong danh sách: chữ Hán, pinyin, nghĩa.
class WordTile extends StatelessWidget {
  const WordTile({super.key, required this.word, this.onTap});

  final Word word;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: SizedBox(
        width: 72,
        child: HanziText(word.hanzi, size: 28, textAlign: TextAlign.center),
      ),
      title: PinyinText(word.pinyin, style: theme.textTheme.titleMedium
          ?.copyWith(fontWeight: FontWeight.w600)),
      subtitle: Text(word.meaningVi, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: const Icon(Icons.chevron_right_rounded),
    );
  }
}
