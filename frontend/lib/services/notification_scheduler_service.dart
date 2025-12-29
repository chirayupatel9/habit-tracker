import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationSchedulerService {
  final FlutterLocalNotificationsPlugin _notifications;

  NotificationSchedulerService(this._notifications) {
    // Initialize timezone data
    tz.initializeTimeZones();
  }

  /// Initialize notification plugin
  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(initSettings);
  }

  /// Schedule daily reminder at specified time
  /// hour: Hour (0-23)
  /// minute: Minute (0-59)
  Future<void> scheduleDailyReminder(int hour, int minute) async {
    // Cancel existing daily reminder first
    await _notifications.cancel(1);

    await _notifications.zonedSchedule(
      1, // ID for daily reminder
      'Daily Habit Check-in',
      'Don\'t forget to track your habits today!',
      _nextInstanceOfTime(hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder',
          'Daily Reminders',
          channelDescription: 'Reminders to track your daily habits',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Schedule weekly summary (Sunday)
  Future<void> scheduleWeeklySummary() async {
    // Cancel existing weekly reminder first
    await _notifications.cancel(2);

    // Schedule for next Sunday at 9 AM
    final now = tz.TZDateTime.now(tz.local);
    var nextSunday = now.add(Duration(days: (7 - now.weekday) % 7));
    if (nextSunday.weekday != DateTime.sunday || nextSunday.isBefore(now)) {
      nextSunday = nextSunday.add(const Duration(days: 7));
    }
    final scheduledTime = tz.TZDateTime(
      tz.local,
      nextSunday.year,
      nextSunday.month,
      nextSunday.day,
      9, // 9 AM
    );

    await _notifications.zonedSchedule(
      2, // ID for weekly summary
      'Weekly Summary',
      'Check out your progress this week!',
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'weekly_summary',
          'Weekly Summaries',
          channelDescription: 'Weekly habit tracking summaries',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  /// Schedule monthly summary (last day of month)
  Future<void> scheduleMonthlySummary() async {
    // Cancel existing monthly reminder first
    await _notifications.cancel(3);

    // Schedule for last day of current month at 6 PM
    final now = tz.TZDateTime.now(tz.local);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    var scheduledTime = tz.TZDateTime(
      tz.local,
      lastDayOfMonth.year,
      lastDayOfMonth.month,
      lastDayOfMonth.day,
      18, // 6 PM
    );

    // If last day has passed, schedule for next month
    if (scheduledTime.isBefore(now)) {
      final nextMonth = DateTime(now.year, now.month + 1, 1);
      final nextLastDay = DateTime(nextMonth.year, nextMonth.month + 1, 0);
      scheduledTime = tz.TZDateTime(
        tz.local,
        nextLastDay.year,
        nextLastDay.month,
        nextLastDay.day,
        18,
      );
    }

    await _notifications.zonedSchedule(
      3, // ID for monthly summary
      'Monthly Summary',
      'Review your monthly progress!',
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'monthly_summary',
          'Monthly Summaries',
          channelDescription: 'Monthly habit tracking summaries',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// Cancel all scheduled notifications
  Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  /// Cancel specific notification by ID
  Future<void> cancel(int id) async {
    await _notifications.cancel(id);
  }

  /// Helper to get next instance of time
  /// hour: Hour (0-23)
  /// minute: Minute (0-59)
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
      0,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}

