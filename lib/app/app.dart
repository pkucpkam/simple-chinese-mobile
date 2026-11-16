import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/widgets/async_value_view.dart';
import '../core/widgets/hanzi_text.dart';
import '../data/providers.dart';
import 'router.dart';
import 'strings.dart';
import 'theme/app_theme.dart';
import 'theme/theme_mode_controller.dart';

class SimpleChineseApp extends ConsumerWidget {
  const SimpleChineseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeControllerProvider).value ?? ThemeMode.system;
    return MaterialApp.router(
      title: S.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: ref.watch(routerProvider),
      // Chặn UI cho tới khi import nội dung xong (lần đầu mở app).
      builder: (context, child) => _ContentGate(child: child!),
    );
  }
}

class _ContentGate extends ConsumerWidget {
  const _ContentGate({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrap = ref.watch(contentBootstrapProvider);
    if (bootstrap.hasValue) return child;
    return Material(
      child: bootstrap.hasError
          ? AsyncValueView(
              value: bootstrap,
              onRetry: () => ref.invalidate(contentBootstrapProvider),
              data: (_) => child,
            )
          : const _Splash(),
    );
  }
}

class _Splash extends StatelessWidget {
  const _Splash();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HanziText('汉语', size: 64, color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(S.loadingContent, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
