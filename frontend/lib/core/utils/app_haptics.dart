import 'package:flutter/services.dart';

/// Centralized haptic feedback utility.
/// 
/// All widgets must use AppHaptics, never HapticFeedback directly.
/// This ensures consistent haptic patterns across the app.
class AppHaptics {
  /// Light impact - for primary button taps (Save, Submit)
  static void light() {
    HapticFeedback.lightImpact();
  }

  /// Medium impact - for success actions (feedback submit, completion)
  static void medium() {
    HapticFeedback.mediumImpact();
  }

  /// Heavy impact - for destructive actions (delete account, critical confirmations)
  static void heavy() {
    HapticFeedback.heavyImpact();
  }

  /// Selection click - for toggles (task on/off, switches)
  static void selection() {
    HapticFeedback.selectionClick();
  }
}

