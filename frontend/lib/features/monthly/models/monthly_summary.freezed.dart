// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monthly_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MonthlyAggregation _$MonthlyAggregationFromJson(Map<String, dynamic> json) {
  return _MonthlyAggregation.fromJson(json);
}

/// @nodoc
mixin _$MonthlyAggregation {
  String get date => throw _privateConstructorUsedError; // Format: YYYY-MM-DD
  @JsonKey(name: 'moment_of_day')
  String? get momentOfDay => throw _privateConstructorUsedError;
  @JsonKey(name: 'sleep_hours')
  double? get sleepHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'daily_note')
  String? get dailyNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'task_completion_counts')
  Map<String, int>? get taskCompletionCounts =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'average_sleep')
  double? get averageSleep => throw _privateConstructorUsedError;

  /// Serializes this MonthlyAggregation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyAggregation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyAggregationCopyWith<MonthlyAggregation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyAggregationCopyWith<$Res> {
  factory $MonthlyAggregationCopyWith(
          MonthlyAggregation value, $Res Function(MonthlyAggregation) then) =
      _$MonthlyAggregationCopyWithImpl<$Res, MonthlyAggregation>;
  @useResult
  $Res call(
      {String date,
      @JsonKey(name: 'moment_of_day') String? momentOfDay,
      @JsonKey(name: 'sleep_hours') double? sleepHours,
      @JsonKey(name: 'daily_note') String? dailyNote,
      @JsonKey(name: 'task_completion_counts')
      Map<String, int>? taskCompletionCounts,
      @JsonKey(name: 'average_sleep') double? averageSleep});
}

/// @nodoc
class _$MonthlyAggregationCopyWithImpl<$Res, $Val extends MonthlyAggregation>
    implements $MonthlyAggregationCopyWith<$Res> {
  _$MonthlyAggregationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyAggregation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? momentOfDay = freezed,
    Object? sleepHours = freezed,
    Object? dailyNote = freezed,
    Object? taskCompletionCounts = freezed,
    Object? averageSleep = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      momentOfDay: freezed == momentOfDay
          ? _value.momentOfDay
          : momentOfDay // ignore: cast_nullable_to_non_nullable
              as String?,
      sleepHours: freezed == sleepHours
          ? _value.sleepHours
          : sleepHours // ignore: cast_nullable_to_non_nullable
              as double?,
      dailyNote: freezed == dailyNote
          ? _value.dailyNote
          : dailyNote // ignore: cast_nullable_to_non_nullable
              as String?,
      taskCompletionCounts: freezed == taskCompletionCounts
          ? _value.taskCompletionCounts
          : taskCompletionCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      averageSleep: freezed == averageSleep
          ? _value.averageSleep
          : averageSleep // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlyAggregationImplCopyWith<$Res>
    implements $MonthlyAggregationCopyWith<$Res> {
  factory _$$MonthlyAggregationImplCopyWith(_$MonthlyAggregationImpl value,
          $Res Function(_$MonthlyAggregationImpl) then) =
      __$$MonthlyAggregationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      @JsonKey(name: 'moment_of_day') String? momentOfDay,
      @JsonKey(name: 'sleep_hours') double? sleepHours,
      @JsonKey(name: 'daily_note') String? dailyNote,
      @JsonKey(name: 'task_completion_counts')
      Map<String, int>? taskCompletionCounts,
      @JsonKey(name: 'average_sleep') double? averageSleep});
}

/// @nodoc
class __$$MonthlyAggregationImplCopyWithImpl<$Res>
    extends _$MonthlyAggregationCopyWithImpl<$Res, _$MonthlyAggregationImpl>
    implements _$$MonthlyAggregationImplCopyWith<$Res> {
  __$$MonthlyAggregationImplCopyWithImpl(_$MonthlyAggregationImpl _value,
      $Res Function(_$MonthlyAggregationImpl) _then)
      : super(_value, _then);

  /// Create a copy of MonthlyAggregation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? momentOfDay = freezed,
    Object? sleepHours = freezed,
    Object? dailyNote = freezed,
    Object? taskCompletionCounts = freezed,
    Object? averageSleep = freezed,
  }) {
    return _then(_$MonthlyAggregationImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      momentOfDay: freezed == momentOfDay
          ? _value.momentOfDay
          : momentOfDay // ignore: cast_nullable_to_non_nullable
              as String?,
      sleepHours: freezed == sleepHours
          ? _value.sleepHours
          : sleepHours // ignore: cast_nullable_to_non_nullable
              as double?,
      dailyNote: freezed == dailyNote
          ? _value.dailyNote
          : dailyNote // ignore: cast_nullable_to_non_nullable
              as String?,
      taskCompletionCounts: freezed == taskCompletionCounts
          ? _value._taskCompletionCounts
          : taskCompletionCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      averageSleep: freezed == averageSleep
          ? _value.averageSleep
          : averageSleep // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyAggregationImpl implements _MonthlyAggregation {
  const _$MonthlyAggregationImpl(
      {required this.date,
      @JsonKey(name: 'moment_of_day') this.momentOfDay,
      @JsonKey(name: 'sleep_hours') this.sleepHours,
      @JsonKey(name: 'daily_note') this.dailyNote,
      @JsonKey(name: 'task_completion_counts')
      final Map<String, int>? taskCompletionCounts,
      @JsonKey(name: 'average_sleep') this.averageSleep})
      : _taskCompletionCounts = taskCompletionCounts;

  factory _$MonthlyAggregationImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyAggregationImplFromJson(json);

  @override
  final String date;
// Format: YYYY-MM-DD
  @override
  @JsonKey(name: 'moment_of_day')
  final String? momentOfDay;
  @override
  @JsonKey(name: 'sleep_hours')
  final double? sleepHours;
  @override
  @JsonKey(name: 'daily_note')
  final String? dailyNote;
  final Map<String, int>? _taskCompletionCounts;
  @override
  @JsonKey(name: 'task_completion_counts')
  Map<String, int>? get taskCompletionCounts {
    final value = _taskCompletionCounts;
    if (value == null) return null;
    if (_taskCompletionCounts is EqualUnmodifiableMapView)
      return _taskCompletionCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'average_sleep')
  final double? averageSleep;

  @override
  String toString() {
    return 'MonthlyAggregation(date: $date, momentOfDay: $momentOfDay, sleepHours: $sleepHours, dailyNote: $dailyNote, taskCompletionCounts: $taskCompletionCounts, averageSleep: $averageSleep)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyAggregationImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.momentOfDay, momentOfDay) ||
                other.momentOfDay == momentOfDay) &&
            (identical(other.sleepHours, sleepHours) ||
                other.sleepHours == sleepHours) &&
            (identical(other.dailyNote, dailyNote) ||
                other.dailyNote == dailyNote) &&
            const DeepCollectionEquality()
                .equals(other._taskCompletionCounts, _taskCompletionCounts) &&
            (identical(other.averageSleep, averageSleep) ||
                other.averageSleep == averageSleep));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      momentOfDay,
      sleepHours,
      dailyNote,
      const DeepCollectionEquality().hash(_taskCompletionCounts),
      averageSleep);

  /// Create a copy of MonthlyAggregation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyAggregationImplCopyWith<_$MonthlyAggregationImpl> get copyWith =>
      __$$MonthlyAggregationImplCopyWithImpl<_$MonthlyAggregationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyAggregationImplToJson(
      this,
    );
  }
}

abstract class _MonthlyAggregation implements MonthlyAggregation {
  const factory _MonthlyAggregation(
          {required final String date,
          @JsonKey(name: 'moment_of_day') final String? momentOfDay,
          @JsonKey(name: 'sleep_hours') final double? sleepHours,
          @JsonKey(name: 'daily_note') final String? dailyNote,
          @JsonKey(name: 'task_completion_counts')
          final Map<String, int>? taskCompletionCounts,
          @JsonKey(name: 'average_sleep') final double? averageSleep}) =
      _$MonthlyAggregationImpl;

  factory _MonthlyAggregation.fromJson(Map<String, dynamic> json) =
      _$MonthlyAggregationImpl.fromJson;

  @override
  String get date; // Format: YYYY-MM-DD
  @override
  @JsonKey(name: 'moment_of_day')
  String? get momentOfDay;
  @override
  @JsonKey(name: 'sleep_hours')
  double? get sleepHours;
  @override
  @JsonKey(name: 'daily_note')
  String? get dailyNote;
  @override
  @JsonKey(name: 'task_completion_counts')
  Map<String, int>? get taskCompletionCounts;
  @override
  @JsonKey(name: 'average_sleep')
  double? get averageSleep;

  /// Create a copy of MonthlyAggregation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyAggregationImplCopyWith<_$MonthlyAggregationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
