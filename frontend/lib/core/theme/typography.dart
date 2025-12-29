import 'package:flutter/material.dart';

/// Typography system for consistent text styles throughout the app.
/// All text styles must use these theme extensions - no inline TextStyles.
extension AppTypography on ThemeData {
  /// Page title style - used for main screen titles
  TextStyle get pageTitle => textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ) ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  /// Section title style - used for section headers
  TextStyle get sectionTitle => textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ) ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  /// Body text style - default body text
  TextStyle get body => textTheme.bodyLarge ??
      const TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

  /// Caption style - smaller supporting text
  TextStyle get caption => textTheme.bodyMedium ??
      const TextStyle(fontSize: 14, fontWeight: FontWeight.normal);

  /// Subtle text style - for secondary/disabled text
  TextStyle get subtle => textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontStyle: FontStyle.italic,
      ) ??
      TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: colorScheme.onSurfaceVariant,
        fontStyle: FontStyle.italic,
      );
}

