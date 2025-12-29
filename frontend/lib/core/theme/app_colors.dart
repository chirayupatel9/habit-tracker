import 'package:flutter/material.dart';

/// Semantic color system - colors defined by meaning, not appearance.
/// 
/// This ensures consistent theming across light and dark modes.
/// All colors should be accessed through Theme.of(context).colorScheme
/// or through semantic color extensions.
abstract class AppColors {
  // Background colors
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color darkBackground = Color(0xFF121212);
  
  // Surface colors
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkSurface = Color(0xFF1E1E1E);
  
  static const Color lightSurfaceVariant = Color(0xFFF5F5F5);
  static const Color darkSurfaceVariant = Color(0xFF2C2C2C);
  
  // Primary colors
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color onPrimary = Color(0xFFFFFFFF);
  
  // Text colors
  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  
  // Divider
  static const Color lightDivider = Color(0xFFE5E7EB);
  static const Color darkDivider = Color(0xFF374151);
  
  // Semantic colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  
  // On colors for semantic
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color onError = Color(0xFFFFFFFF);
}

/// Extension to access semantic colors from ThemeData
extension AppColorScheme on ColorScheme {
  /// Background color for the app
  Color get appBackground => brightness == Brightness.light
      ? AppColors.lightBackground
      : AppColors.darkBackground;
  
  /// Surface color for cards and elevated elements
  Color get appSurface => brightness == Brightness.light
      ? AppColors.lightSurface
      : AppColors.darkSurface;
  
  /// Variant surface color for subtle elevation
  Color get appSurfaceVariant => brightness == Brightness.light
      ? AppColors.lightSurfaceVariant
      : AppColors.darkSurfaceVariant;
  
  /// Primary text color
  Color get appTextPrimary => brightness == Brightness.light
      ? AppColors.lightTextPrimary
      : AppColors.darkTextPrimary;
  
  /// Secondary text color
  Color get appTextSecondary => brightness == Brightness.light
      ? AppColors.lightTextSecondary
      : AppColors.darkTextSecondary;
  
  /// Divider color
  Color get appDivider => brightness == Brightness.light
      ? AppColors.lightDivider
      : AppColors.darkDivider;
  
  /// Success color
  Color get appSuccess => AppColors.success;
  
  /// Warning color
  Color get appWarning => AppColors.warning;
  
  /// Error color (uses Material error color)
  Color get appError => error;
}

