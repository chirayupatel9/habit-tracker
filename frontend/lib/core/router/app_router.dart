// ignore_for_file: invalid_annotation_target
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/providers/auth_providers.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/daily_entry/screens/daily_entry_screen.dart';
import '../../features/monthly/screens/monthly_screen.dart';
import '../../features/yearly/screens/yearly_calendar_screen.dart';
import '../../features/tasks/screens/task_management_screen.dart';
import '../../features/feedback/screens/feedback_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/edit_profile_screen.dart';
import '../../features/profile/screens/change_password_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/settings/screens/delete_account_screen.dart';
import '../../features/premium/screens/premium_screen.dart';

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
      GoRoute(
        path: '/daily-entry',
        name: 'daily-entry',
        builder: (context, state) => const DailyEntryScreen(),
      ),
      GoRoute(
        path: '/monthly',
        name: 'monthly',
        builder: (context, state) => const MonthlyScreen(),
      ),
      GoRoute(
        path: '/yearly',
        name: 'yearly',
        builder: (context, state) => const YearlyCalendarScreen(),
      ),
      GoRoute(
        path: '/tasks',
        name: 'tasks',
        builder: (context, state) => const TaskManagementScreen(),
      ),
        GoRoute(
          path: '/feedback',
          name: 'feedback',
          builder: (context, state) => const FeedbackScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/profile/edit',
          name: 'edit-profile',
          builder: (context, state) => const EditProfileScreen(),
        ),
        GoRoute(
          path: '/profile/change-password',
          name: 'change-password',
          builder: (context, state) => const ChangePasswordScreen(),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/settings/delete-account',
          name: 'delete-account',
          builder: (context, state) => const DeleteAccountScreen(),
        ),
        GoRoute(
          path: '/premium',
          name: 'premium',
          builder: (context, state) => const PremiumScreen(),
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

