import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/providers/auth_providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    // Fallback: Navigate to login after 3 seconds if still on splash
    Future.delayed(const Duration(seconds: 3), () {
      if (!_hasNavigated && mounted) {
        _hasNavigated = true;
        context.go('/login');
      }
    });
  }

  void _navigateBasedOnAuth(bool isAuthenticated) {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;

    // Small delay for splash effect
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      if (isAuthenticated) {
        context.go('/dashboard');
      } else {
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    // Navigate when auth state is ready
    authState.when(
      data: (isAuthenticated) {
        if (!_hasNavigated && mounted) {
          _navigateBasedOnAuth(isAuthenticated);
        }
      },
      loading: () {
        // Show loading indicator
      },
      error: (error, stackTrace) {
        // On error, navigate to login
        if (!_hasNavigated && mounted) {
          _navigateBasedOnAuth(false);
        }
      },
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Habit Tracker',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

