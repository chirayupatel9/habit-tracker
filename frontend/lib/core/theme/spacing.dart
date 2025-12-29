import 'package:flutter/material.dart';

/// Spacing tokens for consistent spacing throughout the app.
/// No magic numbers - all spacing must use these tokens.
class AppSpacing {
  AppSpacing._();

  /// Extra small spacing: 4px
  static const double xs = 4.0;

  /// Small spacing: 8px
  static const double sm = 8.0;

  /// Medium spacing: 16px
  static const double md = 16.0;

  /// Large spacing: 24px
  static const double lg = 24.0;

  /// Extra large spacing: 32px
  static const double xl = 32.0;

  /// EdgeInsets helpers using spacing tokens
  static EdgeInsets allXs = const EdgeInsets.all(xs);
  static EdgeInsets allSm = const EdgeInsets.all(sm);
  static EdgeInsets allMd = const EdgeInsets.all(md);
  static EdgeInsets allLg = const EdgeInsets.all(lg);
  static EdgeInsets allXl = const EdgeInsets.all(xl);

  /// Horizontal padding
  static EdgeInsets horizontalXs = const EdgeInsets.symmetric(horizontal: xs);
  static EdgeInsets horizontalSm = const EdgeInsets.symmetric(horizontal: sm);
  static EdgeInsets horizontalMd = const EdgeInsets.symmetric(horizontal: md);
  static EdgeInsets horizontalLg = const EdgeInsets.symmetric(horizontal: lg);
  static EdgeInsets horizontalXl = const EdgeInsets.symmetric(horizontal: xl);

  /// Vertical padding
  static EdgeInsets verticalXs = const EdgeInsets.symmetric(vertical: xs);
  static EdgeInsets verticalSm = const EdgeInsets.symmetric(vertical: sm);
  static EdgeInsets verticalMd = const EdgeInsets.symmetric(vertical: md);
  static EdgeInsets verticalLg = const EdgeInsets.symmetric(vertical: lg);
  static EdgeInsets verticalXl = const EdgeInsets.symmetric(vertical: xl);

  /// SizedBox helpers
  static Widget sizedBoxXs = const SizedBox(height: xs, width: xs);
  static Widget sizedBoxSm = const SizedBox(height: sm, width: sm);
  static Widget sizedBoxMd = const SizedBox(height: md, width: md);
  static Widget sizedBoxLg = const SizedBox(height: lg, width: lg);
  static Widget sizedBoxXl = const SizedBox(height: xl, width: xl);

  /// Height only
  static Widget heightXs = const SizedBox(height: xs);
  static Widget heightSm = const SizedBox(height: sm);
  static Widget heightMd = const SizedBox(height: md);
  static Widget heightLg = const SizedBox(height: lg);
  static Widget heightXl = const SizedBox(height: xl);

  /// Width only
  static Widget widthXs = const SizedBox(width: xs);
  static Widget widthSm = const SizedBox(width: sm);
  static Widget widthMd = const SizedBox(width: md);
  static Widget widthLg = const SizedBox(width: lg);
  static Widget widthXl = const SizedBox(width: xl);
}

