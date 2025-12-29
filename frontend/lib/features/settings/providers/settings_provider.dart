// ignore_for_file: invalid_annotation_target
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import '../models/app_settings.dart';
import '../../../services/notification_scheduler_service.dart';

part 'settings_provider.g.dart';

@riverpod
class AppSettingsState extends _$AppSettingsState {
  static const String _settingsKey = 'app_settings';

  @override
  Future<AppSettings> build() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsJson = prefs.getString(_settingsKey);

    if (settingsJson != null) {
      try {
        final json = jsonDecode(settingsJson) as Map<String, dynamic>;
        return AppSettings.fromJson(json);
      } catch (e) {
        // If parsing fails, return default settings
        return AppSettings.defaultSettings();
      }
    }

    return AppSettings.defaultSettings();
  }

  Future<void> updateSettings(AppSettings newSettings) async {
    state = const AsyncValue.loading();
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentSettings = await build();
      final settingsJson = jsonEncode(newSettings.toJson());
      await prefs.setString(_settingsKey, settingsJson);

      // Trigger notification rescheduling if notification settings changed
      if (currentSettings.notificationsEnabled !=
              newSettings.notificationsEnabled ||
          currentSettings.dailyReminderHour !=
              newSettings.dailyReminderHour ||
          currentSettings.dailyReminderMinute !=
              newSettings.dailyReminderMinute ||
          currentSettings.weeklySummaryEnabled !=
              newSettings.weeklySummaryEnabled ||
          currentSettings.monthlySummaryEnabled !=
              newSettings.monthlySummaryEnabled) {
        await _rescheduleNotifications(newSettings);
      }

      state = AsyncValue.data(newSettings);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> _rescheduleNotifications(AppSettings settings) async {
    if (!settings.notificationsEnabled) {
      // Cancel all notifications if disabled
      // This would require a method in NotificationSchedulerService
      return;
    }

    // Reschedule daily reminder
    final notifications = FlutterLocalNotificationsPlugin();
    final scheduler = NotificationSchedulerService(notifications);
    await scheduler.scheduleDailyReminder(
      settings.dailyReminderHour,
      settings.dailyReminderMinute,
    );

    // Reschedule weekly summary if enabled
    if (settings.weeklySummaryEnabled) {
      await scheduler.scheduleWeeklySummary();
    }

    // Reschedule monthly summary if enabled
    if (settings.monthlySummaryEnabled) {
      await scheduler.scheduleMonthlySummary();
    }
  }
}

