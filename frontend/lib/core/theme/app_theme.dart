import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

/// App theme configuration
/// 
/// Provides access to light and dark themes.
/// Theme mode is controlled by themeModeProvider.
class AppTheme {
  /// Light theme
  static ThemeData get lightTheme => LightTheme.theme;
  
  /// Dark theme
  static ThemeData get darkTheme => DarkTheme.theme;
}

