import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Typography system for consistent text styles throughout the app.
/// All text styles must use these theme extensions - no inline TextStyles.
extension AppTypography on ThemeData {
  /// Page title style - used for main screen titles
  TextStyle get pageTitle => (textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.appTextPrimary,
      ) ?? TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: colorScheme.appTextPrimary,
      ));

  /// Section title style - used for section headers
  TextStyle get sectionTitle => (textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.appTextPrimary,
      ) ?? TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: colorScheme.appTextPrimary,
      ));

  /// Body text style - default body text
  TextStyle get body => (textTheme.bodyLarge?.copyWith(
        color: colorScheme.appTextPrimary,
      ) ?? TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: colorScheme.appTextPrimary,
      ));

  /// Caption style - smaller supporting text
  TextStyle get caption => (textTheme.bodyMedium?.copyWith(
        color: colorScheme.appTextSecondary,
      ) ?? TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: colorScheme.appTextSecondary,
      ));

  /// Subtle text style - for secondary/disabled text
  TextStyle get subtle => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: colorScheme.appTextSecondary,
        fontStyle: FontStyle.italic,
      );
}

