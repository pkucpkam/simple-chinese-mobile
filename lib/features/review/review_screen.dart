import 'package:flutter/material.dart';

import '../../app/strings.dart';

/// Tab "Ôn tập" — triển khai ở Sprint 1.
class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text(S.reviewTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.style_rounded, size: 64, color: theme.colorScheme.primary),
              const SizedBox(height: 16),
              Text(S.comingSoon, style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              const Text(S.reviewComingSoon, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
