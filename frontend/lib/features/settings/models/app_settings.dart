import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

enum AppThemeMode {
  system,
  light,
  dark,
}

enum FirstDayOfWeek {
  sunday,
  monday,
}

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    // Notifications
    @Default(true) bool notificationsEnabled,
    @Default(9) int dailyReminderHour,
    @Default(0) int dailyReminderMinute,
    @Default(true) bool weeklySummaryEnabled,
    @Default(true) bool monthlySummaryEnabled,

    // App
    @Default(AppThemeMode.system) AppThemeMode themeMode,
    @Default(FirstDayOfWeek.sunday) FirstDayOfWeek firstDayOfWeek,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);

  factory AppSettings.defaultSettings() => const AppSettings();
}

