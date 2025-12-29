import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/settings/models/app_settings.dart';
import '../../features/settings/providers/settings_provider.dart';

part 'theme_mode_provider.g.dart';

/// Provider for theme mode that reads from app settings
@riverpod
ThemeMode themeMode(ThemeModeRef ref) {
  final settingsAsync = ref.watch(appSettingsStateProvider);
  
  return settingsAsync.when(
    loading: () => ThemeMode.system,
    error: (_, __) => ThemeMode.system,
    data: (settings) {
      switch (settings.themeMode) {
        case AppThemeMode.system:
          return ThemeMode.system;
        case AppThemeMode.light:
          return ThemeMode.light;
        case AppThemeMode.dark:
          return ThemeMode.dark;
      }
    },
  );
}

