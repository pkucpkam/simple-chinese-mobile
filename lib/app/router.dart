import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/dictionary/dictionary_screen.dart';
import '../features/dictionary/word_detail_screen.dart';
import '../features/lesson/lesson_screen.dart';
import '../features/path/path_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/pronunciation/drill/drill_builder.dart';
import '../features/pronunciation/drill/drill_screen.dart';
import '../features/pronunciation/pinyin_chart_screen.dart';
import '../features/pronunciation/pronunciation_screen.dart';
import '../features/pronunciation/record_compare_screen.dart';
import '../features/review/review_screen.dart';
import '../features/review/review_session_screen.dart';
import '../features/review/session/session_builder.dart';
import '../features/writing/writing_screen.dart';
import 'routes.dart';
import 'strings.dart';

part 'router.g.dart';

final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: Routes.learn,
    routes: [
      // 4 tab, mỗi tab giữ stack điều hướng riêng (IndexedStack).
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => _HomeShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: Routes.learn, builder: (_, _) => const PathScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: Routes.review, builder: (_, _) => const ReviewScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.dictionary,
              builder: (_, _) => const DictionaryScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: Routes.me, builder: (_, _) => const ProfileScreen()),
          ]),
        ],
      ),
      // Màn toàn màn hình, nằm trên bottom nav.
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.wordPattern,
        builder: (_, state) =>
            WordDetailScreen(wordId: state.pathParameters['id']!),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.sessionPattern,
        builder: (_, state) => ReviewSessionScreen(
          mode: SessionMode.values.byName(state.pathParameters['mode']!),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.lessonPattern,
        builder: (_, state) => LessonScreen(lessonId: state.pathParameters['id']!),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.writePattern,
        builder: (_, state) => WritingScreen(wordId: state.pathParameters['id']!),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.pronunciation,
        builder: (_, _) => const PronunciationScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.pinyinChart,
        builder: (_, _) => const PinyinChartScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.drillPattern,
        builder: (_, state) =>
            DrillScreen(kind: DrillKind.parse(state.pathParameters['kind']!)),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.recordPath,
        builder: (_, state) => RecordCompareScreen(
          hanzi: state.uri.queryParameters['hanzi'] ?? '',
          pinyin: state.uri.queryParameters['pinyin'] ?? '',
        ),
      ),
    ],
  );
}

class _HomeShell extends StatelessWidget {
  const _HomeShell({required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (i) =>
            shell.goBranch(i, initialLocation: i == shell.currentIndex),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.route_outlined),
            selectedIcon: Icon(Icons.route_rounded),
            label: S.tabLearn,
          ),
          NavigationDestination(
            icon: Icon(Icons.style_outlined),
            selectedIcon: Icon(Icons.style_rounded),
            label: S.tabReview,
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            selectedIcon: Icon(Icons.manage_search_rounded),
            label: S.tabDictionary,
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: S.tabMe,
          ),
        ],
      ),
    );
  }
}
