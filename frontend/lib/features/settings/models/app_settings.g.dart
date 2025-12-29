// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingsImpl(
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      dailyReminderHour: (json['dailyReminderHour'] as num?)?.toInt() ?? 9,
      dailyReminderMinute: (json['dailyReminderMinute'] as num?)?.toInt() ?? 0,
      weeklySummaryEnabled: json['weeklySummaryEnabled'] as bool? ?? true,
      monthlySummaryEnabled: json['monthlySummaryEnabled'] as bool? ?? true,
      themeMode:
          $enumDecodeNullable(_$AppThemeModeEnumMap, json['themeMode']) ??
              AppThemeMode.system,
      firstDayOfWeek: $enumDecodeNullable(
              _$FirstDayOfWeekEnumMap, json['firstDayOfWeek']) ??
          FirstDayOfWeek.sunday,
    );

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'notificationsEnabled': instance.notificationsEnabled,
      'dailyReminderHour': instance.dailyReminderHour,
      'dailyReminderMinute': instance.dailyReminderMinute,
      'weeklySummaryEnabled': instance.weeklySummaryEnabled,
      'monthlySummaryEnabled': instance.monthlySummaryEnabled,
      'themeMode': _$AppThemeModeEnumMap[instance.themeMode]!,
      'firstDayOfWeek': _$FirstDayOfWeekEnumMap[instance.firstDayOfWeek]!,
    };

const _$AppThemeModeEnumMap = {
  AppThemeMode.system: 'system',
  AppThemeMode.light: 'light',
  AppThemeMode.dark: 'dark',
};

const _$FirstDayOfWeekEnumMap = {
  FirstDayOfWeek.sunday: 'sunday',
  FirstDayOfWeek.monday: 'monday',
};
