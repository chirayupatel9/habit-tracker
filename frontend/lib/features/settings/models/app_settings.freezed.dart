// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) {
  return _AppSettings.fromJson(json);
}

/// @nodoc
mixin _$AppSettings {
// Notifications
  bool get notificationsEnabled => throw _privateConstructorUsedError;
  int get dailyReminderHour => throw _privateConstructorUsedError;
  int get dailyReminderMinute => throw _privateConstructorUsedError;
  bool get weeklySummaryEnabled => throw _privateConstructorUsedError;
  bool get monthlySummaryEnabled => throw _privateConstructorUsedError; // App
  AppThemeMode get themeMode => throw _privateConstructorUsedError;
  FirstDayOfWeek get firstDayOfWeek => throw _privateConstructorUsedError;

  /// Serializes this AppSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
          AppSettings value, $Res Function(AppSettings) then) =
      _$AppSettingsCopyWithImpl<$Res, AppSettings>;
  @useResult
  $Res call(
      {bool notificationsEnabled,
      int dailyReminderHour,
      int dailyReminderMinute,
      bool weeklySummaryEnabled,
      bool monthlySummaryEnabled,
      AppThemeMode themeMode,
      FirstDayOfWeek firstDayOfWeek});
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res, $Val extends AppSettings>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationsEnabled = null,
    Object? dailyReminderHour = null,
    Object? dailyReminderMinute = null,
    Object? weeklySummaryEnabled = null,
    Object? monthlySummaryEnabled = null,
    Object? themeMode = null,
    Object? firstDayOfWeek = null,
  }) {
    return _then(_value.copyWith(
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyReminderHour: null == dailyReminderHour
          ? _value.dailyReminderHour
          : dailyReminderHour // ignore: cast_nullable_to_non_nullable
              as int,
      dailyReminderMinute: null == dailyReminderMinute
          ? _value.dailyReminderMinute
          : dailyReminderMinute // ignore: cast_nullable_to_non_nullable
              as int,
      weeklySummaryEnabled: null == weeklySummaryEnabled
          ? _value.weeklySummaryEnabled
          : weeklySummaryEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      monthlySummaryEnabled: null == monthlySummaryEnabled
          ? _value.monthlySummaryEnabled
          : monthlySummaryEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as AppThemeMode,
      firstDayOfWeek: null == firstDayOfWeek
          ? _value.firstDayOfWeek
          : firstDayOfWeek // ignore: cast_nullable_to_non_nullable
              as FirstDayOfWeek,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppSettingsImplCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$$AppSettingsImplCopyWith(
          _$AppSettingsImpl value, $Res Function(_$AppSettingsImpl) then) =
      __$$AppSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool notificationsEnabled,
      int dailyReminderHour,
      int dailyReminderMinute,
      bool weeklySummaryEnabled,
      bool monthlySummaryEnabled,
      AppThemeMode themeMode,
      FirstDayOfWeek firstDayOfWeek});
}

/// @nodoc
class __$$AppSettingsImplCopyWithImpl<$Res>
    extends _$AppSettingsCopyWithImpl<$Res, _$AppSettingsImpl>
    implements _$$AppSettingsImplCopyWith<$Res> {
  __$$AppSettingsImplCopyWithImpl(
      _$AppSettingsImpl _value, $Res Function(_$AppSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationsEnabled = null,
    Object? dailyReminderHour = null,
    Object? dailyReminderMinute = null,
    Object? weeklySummaryEnabled = null,
    Object? monthlySummaryEnabled = null,
    Object? themeMode = null,
    Object? firstDayOfWeek = null,
  }) {
    return _then(_$AppSettingsImpl(
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyReminderHour: null == dailyReminderHour
          ? _value.dailyReminderHour
          : dailyReminderHour // ignore: cast_nullable_to_non_nullable
              as int,
      dailyReminderMinute: null == dailyReminderMinute
          ? _value.dailyReminderMinute
          : dailyReminderMinute // ignore: cast_nullable_to_non_nullable
              as int,
      weeklySummaryEnabled: null == weeklySummaryEnabled
          ? _value.weeklySummaryEnabled
          : weeklySummaryEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      monthlySummaryEnabled: null == monthlySummaryEnabled
          ? _value.monthlySummaryEnabled
          : monthlySummaryEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as AppThemeMode,
      firstDayOfWeek: null == firstDayOfWeek
          ? _value.firstDayOfWeek
          : firstDayOfWeek // ignore: cast_nullable_to_non_nullable
              as FirstDayOfWeek,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppSettingsImpl implements _AppSettings {
  const _$AppSettingsImpl(
      {this.notificationsEnabled = true,
      this.dailyReminderHour = 9,
      this.dailyReminderMinute = 0,
      this.weeklySummaryEnabled = true,
      this.monthlySummaryEnabled = true,
      this.themeMode = AppThemeMode.system,
      this.firstDayOfWeek = FirstDayOfWeek.sunday});

  factory _$AppSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppSettingsImplFromJson(json);

// Notifications
  @override
  @JsonKey()
  final bool notificationsEnabled;
  @override
  @JsonKey()
  final int dailyReminderHour;
  @override
  @JsonKey()
  final int dailyReminderMinute;
  @override
  @JsonKey()
  final bool weeklySummaryEnabled;
  @override
  @JsonKey()
  final bool monthlySummaryEnabled;
// App
  @override
  @JsonKey()
  final AppThemeMode themeMode;
  @override
  @JsonKey()
  final FirstDayOfWeek firstDayOfWeek;

  @override
  String toString() {
    return 'AppSettings(notificationsEnabled: $notificationsEnabled, dailyReminderHour: $dailyReminderHour, dailyReminderMinute: $dailyReminderMinute, weeklySummaryEnabled: $weeklySummaryEnabled, monthlySummaryEnabled: $monthlySummaryEnabled, themeMode: $themeMode, firstDayOfWeek: $firstDayOfWeek)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingsImpl &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            (identical(other.dailyReminderHour, dailyReminderHour) ||
                other.dailyReminderHour == dailyReminderHour) &&
            (identical(other.dailyReminderMinute, dailyReminderMinute) ||
                other.dailyReminderMinute == dailyReminderMinute) &&
            (identical(other.weeklySummaryEnabled, weeklySummaryEnabled) ||
                other.weeklySummaryEnabled == weeklySummaryEnabled) &&
            (identical(other.monthlySummaryEnabled, monthlySummaryEnabled) ||
                other.monthlySummaryEnabled == monthlySummaryEnabled) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.firstDayOfWeek, firstDayOfWeek) ||
                other.firstDayOfWeek == firstDayOfWeek));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      notificationsEnabled,
      dailyReminderHour,
      dailyReminderMinute,
      weeklySummaryEnabled,
      monthlySummaryEnabled,
      themeMode,
      firstDayOfWeek);

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      __$$AppSettingsImplCopyWithImpl<_$AppSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppSettingsImplToJson(
      this,
    );
  }
}

abstract class _AppSettings implements AppSettings {
  const factory _AppSettings(
      {final bool notificationsEnabled,
      final int dailyReminderHour,
      final int dailyReminderMinute,
      final bool weeklySummaryEnabled,
      final bool monthlySummaryEnabled,
      final AppThemeMode themeMode,
      final FirstDayOfWeek firstDayOfWeek}) = _$AppSettingsImpl;

  factory _AppSettings.fromJson(Map<String, dynamic> json) =
      _$AppSettingsImpl.fromJson;

// Notifications
  @override
  bool get notificationsEnabled;
  @override
  int get dailyReminderHour;
  @override
  int get dailyReminderMinute;
  @override
  bool get weeklySummaryEnabled;
  @override
  bool get monthlySummaryEnabled; // App
  @override
  AppThemeMode get themeMode;
  @override
  FirstDayOfWeek get firstDayOfWeek;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
