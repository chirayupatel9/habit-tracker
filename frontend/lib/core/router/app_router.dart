// ignore_for_file: invalid_annotation_target
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/providers/auth_providers.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/splash/screens/splash_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authStateProvider);
  final router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      // Allow splash to handle its own navigation
      if (state.matchedLocation == '/splash') {
        return null;
      }

      // If auth state is still loading, don't redirect yet
      if (authState.isLoading) {
        return null;
      }

      final isAuthenticated = authState.valueOrNull ?? false;
      final isGoingToAuth = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      // If not authenticated and not going to auth, redirect to login
      if (!isAuthenticated && !isGoingToAuth) {
        return '/login';
      }

      // If authenticated and going to auth, redirect to dashboard
      if (isAuthenticated && isGoingToAuth) {
        return '/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
  );

  // Listen to auth state changes and refresh router
  ref.listen<AsyncValue<bool>>(
    authStateProvider,
    (previous, next) {
      final wasAuthenticated = previous?.valueOrNull ?? false;
      final isAuthenticated = next.valueOrNull ?? false;
      
      // Only refresh if auth state actually changed
      if (wasAuthenticated != isAuthenticated) {
        router.refresh();
      }
    },
  );

  return router;
}

