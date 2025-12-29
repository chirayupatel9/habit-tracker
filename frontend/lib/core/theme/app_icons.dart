import 'package:flutter/material.dart';

/// Centralized iconography system.
/// 
/// Rules:
/// - Use Material Symbols (Outlined) only
/// - No filled icons
/// - No mixed icon sizes
/// - All screens and navigation must use AppIcons
class AppIcons {
  // Navigation icons (24dp)
  static const IconData dashboard = Icons.dashboard_outlined;
  static const IconData daily = Icons.today_outlined;
  static const IconData monthly = Icons.calendar_month_outlined;
  static const IconData yearly = Icons.view_module_outlined;
  static const IconData tasks = Icons.checklist_outlined;
  static const IconData profile = Icons.person_outline;
  static const IconData settings = Icons.settings_outlined;
  static const IconData feedback = Icons.feedback_outlined;
  static const IconData premium = Icons.star_outline;
  static const IconData logout = Icons.logout;

  // Action icons (20dp)
  static const IconData add = Icons.add_outlined;
  static const IconData edit = Icons.edit_outlined;
  static const IconData delete = Icons.delete_outlined;
  static const IconData save = Icons.save_outlined;
  static const IconData cancel = Icons.cancel_outlined;
  static const IconData check = Icons.check_outlined;
  static const IconData close = Icons.close_outlined;
  static const IconData refresh = Icons.refresh_outlined;
  static const IconData search = Icons.search_outlined;
  static const IconData filter = Icons.filter_list_outlined;

  // Feature icons (18dp)
  static const IconData sleep = Icons.bedtime_outlined;
  static const IconData insights = Icons.insights_outlined;
  static const IconData export = Icons.download_outlined;
  static const IconData reminder = Icons.notifications_outlined;
  static const IconData theme = Icons.palette_outlined;
  static const IconData lock = Icons.lock_outline;
  static const IconData email = Icons.email_outlined;
  static const IconData calendar = Icons.calendar_today_outlined;
  static const IconData autoAwesome = Icons.auto_awesome_outlined;
  static const IconData warning = Icons.warning_amber_outlined;
  static const IconData error = Icons.error_outline;
  static const IconData success = Icons.check_circle_outline;
  static const IconData info = Icons.info_outline;

  /// Get icon with consistent size for navigation (24dp)
  static Widget navigation(IconData icon, {Color? color}) {
    return Icon(icon, size: 24, color: color);
  }

  /// Get icon with consistent size for actions (20dp)
  static Widget action(IconData icon, {Color? color}) {
    return Icon(icon, size: 20, color: color);
  }

  /// Get icon with consistent size for inline use (18dp)
  static Widget inline(IconData icon, {Color? color}) {
    return Icon(icon, size: 18, color: color);
  }
}

