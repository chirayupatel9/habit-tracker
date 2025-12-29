// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyEntry _$DailyEntryFromJson(Map<String, dynamic> json) {
  return _DailyEntry.fromJson(json);
}

/// @nodoc
mixin _$DailyEntry {
  String get date => throw _privateConstructorUsedError; // Format: YYYY-MM-DD
  @JsonKey(name: 'moment_of_day')
  String? get momentOfDay => throw _privateConstructorUsedError;
  @JsonKey(name: 'sleep_hours')
  double? get sleepHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'daily_note')
  String? get dailyNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'task_completions')
  List<TaskCompletion> get taskCompletions =>
      throw _privateConstructorUsedError; // Response-only fields
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DailyEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyEntryCopyWith<DailyEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyEntryCopyWith<$Res> {
  factory $DailyEntryCopyWith(
          DailyEntry value, $Res Function(DailyEntry) then) =
      _$DailyEntryCopyWithImpl<$Res, DailyEntry>;
  @useResult
  $Res call(
      {String date,
      @JsonKey(name: 'moment_of_day') String? momentOfDay,
      @JsonKey(name: 'sleep_hours') double? sleepHours,
      @JsonKey(name: 'daily_note') String? dailyNote,
      @JsonKey(name: 'task_completions') List<TaskCompletion> taskCompletions,
      String? id,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class _$DailyEntryCopyWithImpl<$Res, $Val extends DailyEntry>
    implements $DailyEntryCopyWith<$Res> {
  _$DailyEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? momentOfDay = freezed,
    Object? sleepHours = freezed,
    Object? dailyNote = freezed,
    Object? taskCompletions = null,
    Object? id = freezed,
    Object? userId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      taskCompletions: null == taskCompletions
          ? _value.taskCompletions
          : taskCompletions // ignore: cast_nullable_to_non_nullable
              as List<TaskCompletion>,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyEntryImplCopyWith<$Res>
    implements $DailyEntryCopyWith<$Res> {
  factory _$$DailyEntryImplCopyWith(
          _$DailyEntryImpl value, $Res Function(_$DailyEntryImpl) then) =
      __$$DailyEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      @JsonKey(name: 'moment_of_day') String? momentOfDay,
      @JsonKey(name: 'sleep_hours') double? sleepHours,
      @JsonKey(name: 'daily_note') String? dailyNote,
      @JsonKey(name: 'task_completions') List<TaskCompletion> taskCompletions,
      String? id,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class __$$DailyEntryImplCopyWithImpl<$Res>
    extends _$DailyEntryCopyWithImpl<$Res, _$DailyEntryImpl>
    implements _$$DailyEntryImplCopyWith<$Res> {
  __$$DailyEntryImplCopyWithImpl(
      _$DailyEntryImpl _value, $Res Function(_$DailyEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? momentOfDay = freezed,
    Object? sleepHours = freezed,
    Object? dailyNote = freezed,
    Object? taskCompletions = null,
    Object? id = freezed,
    Object? userId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DailyEntryImpl(
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
      taskCompletions: null == taskCompletions
          ? _value._taskCompletions
          : taskCompletions // ignore: cast_nullable_to_non_nullable
              as List<TaskCompletion>,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyEntryImpl implements _DailyEntry {
  const _$DailyEntryImpl(
      {required this.date,
      @JsonKey(name: 'moment_of_day') this.momentOfDay,
      @JsonKey(name: 'sleep_hours') this.sleepHours,
      @JsonKey(name: 'daily_note') this.dailyNote,
      @JsonKey(name: 'task_completions')
      final List<TaskCompletion> taskCompletions = const [],
      this.id,
      @JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _taskCompletions = taskCompletions;

  factory _$DailyEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyEntryImplFromJson(json);

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
  final List<TaskCompletion> _taskCompletions;
  @override
  @JsonKey(name: 'task_completions')
  List<TaskCompletion> get taskCompletions {
    if (_taskCompletions is EqualUnmodifiableListView) return _taskCompletions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskCompletions);
  }

// Response-only fields
  @override
  final String? id;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'DailyEntry(date: $date, momentOfDay: $momentOfDay, sleepHours: $sleepHours, dailyNote: $dailyNote, taskCompletions: $taskCompletions, id: $id, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyEntryImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.momentOfDay, momentOfDay) ||
                other.momentOfDay == momentOfDay) &&
            (identical(other.sleepHours, sleepHours) ||
                other.sleepHours == sleepHours) &&
            (identical(other.dailyNote, dailyNote) ||
                other.dailyNote == dailyNote) &&
            const DeepCollectionEquality()
                .equals(other._taskCompletions, _taskCompletions) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      momentOfDay,
      sleepHours,
      dailyNote,
      const DeepCollectionEquality().hash(_taskCompletions),
      id,
      userId,
      createdAt,
      updatedAt);

  /// Create a copy of DailyEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyEntryImplCopyWith<_$DailyEntryImpl> get copyWith =>
      __$$DailyEntryImplCopyWithImpl<_$DailyEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyEntryImplToJson(
      this,
    );
  }
}

abstract class _DailyEntry implements DailyEntry {
  const factory _DailyEntry(
      {required final String date,
      @JsonKey(name: 'moment_of_day') final String? momentOfDay,
      @JsonKey(name: 'sleep_hours') final double? sleepHours,
      @JsonKey(name: 'daily_note') final String? dailyNote,
      @JsonKey(name: 'task_completions')
      final List<TaskCompletion> taskCompletions,
      final String? id,
      @JsonKey(name: 'user_id') final String? userId,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt}) = _$DailyEntryImpl;

  factory _DailyEntry.fromJson(Map<String, dynamic> json) =
      _$DailyEntryImpl.fromJson;

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
  @JsonKey(name: 'task_completions')
  List<TaskCompletion> get taskCompletions; // Response-only fields
  @override
  String? get id;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of DailyEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyEntryImplCopyWith<_$DailyEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
