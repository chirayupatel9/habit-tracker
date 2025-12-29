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

MonthlySummary _$MonthlySummaryFromJson(Map<String, dynamic> json) {
  return _MonthlySummary.fromJson(json);
}

/// @nodoc
mixin _$MonthlySummary {
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_sleep')
  double? get averageSleep => throw _privateConstructorUsedError;
  @JsonKey(name: 'task_completion_summary')
  Map<String, int>? get taskCompletionSummary =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'daily_notes')
  List<DailyNoteEntry>? get dailyNotes => throw _privateConstructorUsedError;
  @JsonKey(name: 'random_moment')
  RandomMoment? get randomMoment => throw _privateConstructorUsedError;

  /// Serializes this MonthlySummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlySummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlySummaryCopyWith<MonthlySummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlySummaryCopyWith<$Res> {
  factory $MonthlySummaryCopyWith(
          MonthlySummary value, $Res Function(MonthlySummary) then) =
      _$MonthlySummaryCopyWithImpl<$Res, MonthlySummary>;
  @useResult
  $Res call(
      {int year,
      int month,
      @JsonKey(name: 'average_sleep') double? averageSleep,
      @JsonKey(name: 'task_completion_summary')
      Map<String, int>? taskCompletionSummary,
      @JsonKey(name: 'daily_notes') List<DailyNoteEntry>? dailyNotes,
      @JsonKey(name: 'random_moment') RandomMoment? randomMoment});

  $RandomMomentCopyWith<$Res>? get randomMoment;
}

/// @nodoc
class _$MonthlySummaryCopyWithImpl<$Res, $Val extends MonthlySummary>
    implements $MonthlySummaryCopyWith<$Res> {
  _$MonthlySummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlySummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? averageSleep = freezed,
    Object? taskCompletionSummary = freezed,
    Object? dailyNotes = freezed,
    Object? randomMoment = freezed,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      averageSleep: freezed == averageSleep
          ? _value.averageSleep
          : averageSleep // ignore: cast_nullable_to_non_nullable
              as double?,
      taskCompletionSummary: freezed == taskCompletionSummary
          ? _value.taskCompletionSummary
          : taskCompletionSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      dailyNotes: freezed == dailyNotes
          ? _value.dailyNotes
          : dailyNotes // ignore: cast_nullable_to_non_nullable
              as List<DailyNoteEntry>?,
      randomMoment: freezed == randomMoment
          ? _value.randomMoment
          : randomMoment // ignore: cast_nullable_to_non_nullable
              as RandomMoment?,
    ) as $Val);
  }

  /// Create a copy of MonthlySummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RandomMomentCopyWith<$Res>? get randomMoment {
    if (_value.randomMoment == null) {
      return null;
    }

    return $RandomMomentCopyWith<$Res>(_value.randomMoment!, (value) {
      return _then(_value.copyWith(randomMoment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MonthlySummaryImplCopyWith<$Res>
    implements $MonthlySummaryCopyWith<$Res> {
  factory _$$MonthlySummaryImplCopyWith(_$MonthlySummaryImpl value,
          $Res Function(_$MonthlySummaryImpl) then) =
      __$$MonthlySummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int year,
      int month,
      @JsonKey(name: 'average_sleep') double? averageSleep,
      @JsonKey(name: 'task_completion_summary')
      Map<String, int>? taskCompletionSummary,
      @JsonKey(name: 'daily_notes') List<DailyNoteEntry>? dailyNotes,
      @JsonKey(name: 'random_moment') RandomMoment? randomMoment});

  @override
  $RandomMomentCopyWith<$Res>? get randomMoment;
}

/// @nodoc
class __$$MonthlySummaryImplCopyWithImpl<$Res>
    extends _$MonthlySummaryCopyWithImpl<$Res, _$MonthlySummaryImpl>
    implements _$$MonthlySummaryImplCopyWith<$Res> {
  __$$MonthlySummaryImplCopyWithImpl(
      _$MonthlySummaryImpl _value, $Res Function(_$MonthlySummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of MonthlySummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? averageSleep = freezed,
    Object? taskCompletionSummary = freezed,
    Object? dailyNotes = freezed,
    Object? randomMoment = freezed,
  }) {
    return _then(_$MonthlySummaryImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      averageSleep: freezed == averageSleep
          ? _value.averageSleep
          : averageSleep // ignore: cast_nullable_to_non_nullable
              as double?,
      taskCompletionSummary: freezed == taskCompletionSummary
          ? _value._taskCompletionSummary
          : taskCompletionSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      dailyNotes: freezed == dailyNotes
          ? _value._dailyNotes
          : dailyNotes // ignore: cast_nullable_to_non_nullable
              as List<DailyNoteEntry>?,
      randomMoment: freezed == randomMoment
          ? _value.randomMoment
          : randomMoment // ignore: cast_nullable_to_non_nullable
              as RandomMoment?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlySummaryImpl implements _MonthlySummary {
  const _$MonthlySummaryImpl(
      {required this.year,
      required this.month,
      @JsonKey(name: 'average_sleep') this.averageSleep,
      @JsonKey(name: 'task_completion_summary')
      final Map<String, int>? taskCompletionSummary,
      @JsonKey(name: 'daily_notes') final List<DailyNoteEntry>? dailyNotes,
      @JsonKey(name: 'random_moment') this.randomMoment})
      : _taskCompletionSummary = taskCompletionSummary,
        _dailyNotes = dailyNotes;

  factory _$MonthlySummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlySummaryImplFromJson(json);

  @override
  final int year;
  @override
  final int month;
  @override
  @JsonKey(name: 'average_sleep')
  final double? averageSleep;
  final Map<String, int>? _taskCompletionSummary;
  @override
  @JsonKey(name: 'task_completion_summary')
  Map<String, int>? get taskCompletionSummary {
    final value = _taskCompletionSummary;
    if (value == null) return null;
    if (_taskCompletionSummary is EqualUnmodifiableMapView)
      return _taskCompletionSummary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<DailyNoteEntry>? _dailyNotes;
  @override
  @JsonKey(name: 'daily_notes')
  List<DailyNoteEntry>? get dailyNotes {
    final value = _dailyNotes;
    if (value == null) return null;
    if (_dailyNotes is EqualUnmodifiableListView) return _dailyNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'random_moment')
  final RandomMoment? randomMoment;

  @override
  String toString() {
    return 'MonthlySummary(year: $year, month: $month, averageSleep: $averageSleep, taskCompletionSummary: $taskCompletionSummary, dailyNotes: $dailyNotes, randomMoment: $randomMoment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlySummaryImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.averageSleep, averageSleep) ||
                other.averageSleep == averageSleep) &&
            const DeepCollectionEquality()
                .equals(other._taskCompletionSummary, _taskCompletionSummary) &&
            const DeepCollectionEquality()
                .equals(other._dailyNotes, _dailyNotes) &&
            (identical(other.randomMoment, randomMoment) ||
                other.randomMoment == randomMoment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      year,
      month,
      averageSleep,
      const DeepCollectionEquality().hash(_taskCompletionSummary),
      const DeepCollectionEquality().hash(_dailyNotes),
      randomMoment);

  /// Create a copy of MonthlySummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlySummaryImplCopyWith<_$MonthlySummaryImpl> get copyWith =>
      __$$MonthlySummaryImplCopyWithImpl<_$MonthlySummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlySummaryImplToJson(
      this,
    );
  }
}

abstract class _MonthlySummary implements MonthlySummary {
  const factory _MonthlySummary(
          {required final int year,
          required final int month,
          @JsonKey(name: 'average_sleep') final double? averageSleep,
          @JsonKey(name: 'task_completion_summary')
          final Map<String, int>? taskCompletionSummary,
          @JsonKey(name: 'daily_notes') final List<DailyNoteEntry>? dailyNotes,
          @JsonKey(name: 'random_moment') final RandomMoment? randomMoment}) =
      _$MonthlySummaryImpl;

  factory _MonthlySummary.fromJson(Map<String, dynamic> json) =
      _$MonthlySummaryImpl.fromJson;

  @override
  int get year;
  @override
  int get month;
  @override
  @JsonKey(name: 'average_sleep')
  double? get averageSleep;
  @override
  @JsonKey(name: 'task_completion_summary')
  Map<String, int>? get taskCompletionSummary;
  @override
  @JsonKey(name: 'daily_notes')
  List<DailyNoteEntry>? get dailyNotes;
  @override
  @JsonKey(name: 'random_moment')
  RandomMoment? get randomMoment;

  /// Create a copy of MonthlySummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlySummaryImplCopyWith<_$MonthlySummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyNoteEntry _$DailyNoteEntryFromJson(Map<String, dynamic> json) {
  return _DailyNoteEntry.fromJson(json);
}

/// @nodoc
mixin _$DailyNoteEntry {
  String get date => throw _privateConstructorUsedError; // Format: YYYY-MM-DD
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this DailyNoteEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyNoteEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyNoteEntryCopyWith<DailyNoteEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyNoteEntryCopyWith<$Res> {
  factory $DailyNoteEntryCopyWith(
          DailyNoteEntry value, $Res Function(DailyNoteEntry) then) =
      _$DailyNoteEntryCopyWithImpl<$Res, DailyNoteEntry>;
  @useResult
  $Res call({String date, String? note});
}

/// @nodoc
class _$DailyNoteEntryCopyWithImpl<$Res, $Val extends DailyNoteEntry>
    implements $DailyNoteEntryCopyWith<$Res> {
  _$DailyNoteEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyNoteEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyNoteEntryImplCopyWith<$Res>
    implements $DailyNoteEntryCopyWith<$Res> {
  factory _$$DailyNoteEntryImplCopyWith(_$DailyNoteEntryImpl value,
          $Res Function(_$DailyNoteEntryImpl) then) =
      __$$DailyNoteEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, String? note});
}

/// @nodoc
class __$$DailyNoteEntryImplCopyWithImpl<$Res>
    extends _$DailyNoteEntryCopyWithImpl<$Res, _$DailyNoteEntryImpl>
    implements _$$DailyNoteEntryImplCopyWith<$Res> {
  __$$DailyNoteEntryImplCopyWithImpl(
      _$DailyNoteEntryImpl _value, $Res Function(_$DailyNoteEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyNoteEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? note = freezed,
  }) {
    return _then(_$DailyNoteEntryImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyNoteEntryImpl implements _DailyNoteEntry {
  const _$DailyNoteEntryImpl({required this.date, this.note});

  factory _$DailyNoteEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyNoteEntryImplFromJson(json);

  @override
  final String date;
// Format: YYYY-MM-DD
  @override
  final String? note;

  @override
  String toString() {
    return 'DailyNoteEntry(date: $date, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyNoteEntryImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, note);

  /// Create a copy of DailyNoteEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyNoteEntryImplCopyWith<_$DailyNoteEntryImpl> get copyWith =>
      __$$DailyNoteEntryImplCopyWithImpl<_$DailyNoteEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyNoteEntryImplToJson(
      this,
    );
  }
}

abstract class _DailyNoteEntry implements DailyNoteEntry {
  const factory _DailyNoteEntry(
      {required final String date, final String? note}) = _$DailyNoteEntryImpl;

  factory _DailyNoteEntry.fromJson(Map<String, dynamic> json) =
      _$DailyNoteEntryImpl.fromJson;

  @override
  String get date; // Format: YYYY-MM-DD
  @override
  String? get note;

  /// Create a copy of DailyNoteEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyNoteEntryImplCopyWith<_$DailyNoteEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RandomMoment _$RandomMomentFromJson(Map<String, dynamic> json) {
  return _RandomMoment.fromJson(json);
}

/// @nodoc
mixin _$RandomMoment {
  String get date => throw _privateConstructorUsedError; // Format: YYYY-MM-DD
  String get moment => throw _privateConstructorUsedError;

  /// Serializes this RandomMoment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RandomMoment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RandomMomentCopyWith<RandomMoment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RandomMomentCopyWith<$Res> {
  factory $RandomMomentCopyWith(
          RandomMoment value, $Res Function(RandomMoment) then) =
      _$RandomMomentCopyWithImpl<$Res, RandomMoment>;
  @useResult
  $Res call({String date, String moment});
}

/// @nodoc
class _$RandomMomentCopyWithImpl<$Res, $Val extends RandomMoment>
    implements $RandomMomentCopyWith<$Res> {
  _$RandomMomentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RandomMoment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? moment = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      moment: null == moment
          ? _value.moment
          : moment // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RandomMomentImplCopyWith<$Res>
    implements $RandomMomentCopyWith<$Res> {
  factory _$$RandomMomentImplCopyWith(
          _$RandomMomentImpl value, $Res Function(_$RandomMomentImpl) then) =
      __$$RandomMomentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, String moment});
}

/// @nodoc
class __$$RandomMomentImplCopyWithImpl<$Res>
    extends _$RandomMomentCopyWithImpl<$Res, _$RandomMomentImpl>
    implements _$$RandomMomentImplCopyWith<$Res> {
  __$$RandomMomentImplCopyWithImpl(
      _$RandomMomentImpl _value, $Res Function(_$RandomMomentImpl) _then)
      : super(_value, _then);

  /// Create a copy of RandomMoment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? moment = null,
  }) {
    return _then(_$RandomMomentImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      moment: null == moment
          ? _value.moment
          : moment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RandomMomentImpl implements _RandomMoment {
  const _$RandomMomentImpl({required this.date, required this.moment});

  factory _$RandomMomentImpl.fromJson(Map<String, dynamic> json) =>
      _$$RandomMomentImplFromJson(json);

  @override
  final String date;
// Format: YYYY-MM-DD
  @override
  final String moment;

  @override
  String toString() {
    return 'RandomMoment(date: $date, moment: $moment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RandomMomentImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.moment, moment) || other.moment == moment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, moment);

  /// Create a copy of RandomMoment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RandomMomentImplCopyWith<_$RandomMomentImpl> get copyWith =>
      __$$RandomMomentImplCopyWithImpl<_$RandomMomentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RandomMomentImplToJson(
      this,
    );
  }
}

abstract class _RandomMoment implements RandomMoment {
  const factory _RandomMoment(
      {required final String date,
      required final String moment}) = _$RandomMomentImpl;

  factory _RandomMoment.fromJson(Map<String, dynamic> json) =
      _$RandomMomentImpl.fromJson;

  @override
  String get date; // Format: YYYY-MM-DD
  @override
  String get moment;

  /// Create a copy of RandomMoment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RandomMomentImplCopyWith<_$RandomMomentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
