import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/errors/app_error.dart';
import 'core/errors/error_mapper.dart';
import 'features/auth/providers/auth_providers.dart';
import 'services/api_client.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    // Listen for 401 errors globally and logout
    ref.listen<AsyncValue<bool>>(
      authStateProvider,
      (previous, next) {
        // Handle auth state changes
      },
    );

    return MaterialApp.router(
      title: 'Habit Tracker',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Global error handling can be added here if needed
        return child ?? const SizedBox();
      },
    );
  }
}

