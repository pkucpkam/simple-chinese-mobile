import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../app/strings.dart';
import '../../core/widgets/async_value_view.dart';
import '../../core/widgets/hanzi_text.dart';
import '../../data/models/lesson.dart';
import '../../data/providers.dart';
import 'path_providers.dart';

/// Tab "Học". Sprint 0: danh sách bài + từ vựng của bài.
/// Sprint 3 sẽ thay bằng lộ trình dạng path cuộn dọc và 5 bước học.
class PathScreen extends ConsumerWidget {
  const PathScreen({super.key});

  static const level = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessons = ref.watch(lessonsProvider(level));
    return Scaffold(
      appBar: AppBar(title: const Text(S.learnTitle)),
      body: AsyncValueView(
        value: lessons,
        data: (items) => ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 16),
          itemBuilder: (_, i) => _LessonCard(lesson: items[i]),
        ),
      ),
    );
  }
}

class _LessonCard extends ConsumerWidget {
  const _LessonCard({required this.lesson});

  final LessonSummary lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final words = ref.watch(lessonWordsProvider(lesson.id));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.lessonNumber(lesson.order),
              style: theme.textTheme.labelLarge
                  ?.copyWith(color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 4),
            Text(lesson.title, style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700)),
            if (lesson.subtitle.isNotEmpty)
              Text(lesson.subtitle, style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 16),
            words.when(
              data: (ws) => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final w in ws)
                    ActionChip(
                      label: HanziText(w.hanzi, size: 18, serif: false),
                      onPressed: () => context.push(Routes.word(w.id)),
                    ),
                ],
              ),
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('$e'),
            ),
            // Tạm thời (Sprint 1): thêm thủ công. Sprint 3 sẽ tự thêm khi học xong bài.
            if (words.hasValue) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () async {
                    await ref.read(srsRepositoryProvider)
                        .addWords(words.requireValue.map((w) => w.id));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text(S.addedToDeck)));
                    }
                  },
                  icon: const Icon(Icons.library_add_rounded),
                  label: const Text(S.addLessonToDeck),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
