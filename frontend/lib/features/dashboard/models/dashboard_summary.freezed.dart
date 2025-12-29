// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DashboardSummary _$DashboardSummaryFromJson(Map<String, dynamic> json) {
  return _DashboardSummary.fromJson(json);
}

/// @nodoc
mixin _$DashboardSummary {
  @JsonKey(name: 'random_moment')
  String? get randomMoment => throw _privateConstructorUsedError;
  @JsonKey(name: 'random_moment_date')
  String? get randomMomentDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_sleep_7_days')
  double? get averageSleep7Days => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_sleep_30_days')
  double? get averageSleep30Days => throw _privateConstructorUsedError;
  @JsonKey(name: 'sleep_trend')
  String? get sleepTrend =>
      throw _privateConstructorUsedError; // 'up', 'down', 'stable'
  @JsonKey(name: 'task_consistency_percentage')
  double? get taskConsistencyPercentage => throw _privateConstructorUsedError;

  /// Serializes this DashboardSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardSummaryCopyWith<DashboardSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardSummaryCopyWith<$Res> {
  factory $DashboardSummaryCopyWith(
          DashboardSummary value, $Res Function(DashboardSummary) then) =
      _$DashboardSummaryCopyWithImpl<$Res, DashboardSummary>;
  @useResult
  $Res call(
      {@JsonKey(name: 'random_moment') String? randomMoment,
      @JsonKey(name: 'random_moment_date') String? randomMomentDate,
      @JsonKey(name: 'average_sleep_7_days') double? averageSleep7Days,
      @JsonKey(name: 'average_sleep_30_days') double? averageSleep30Days,
      @JsonKey(name: 'sleep_trend') String? sleepTrend,
      @JsonKey(name: 'task_consistency_percentage')
      double? taskConsistencyPercentage});
}

/// @nodoc
class _$DashboardSummaryCopyWithImpl<$Res, $Val extends DashboardSummary>
    implements $DashboardSummaryCopyWith<$Res> {
  _$DashboardSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? randomMoment = freezed,
    Object? randomMomentDate = freezed,
    Object? averageSleep7Days = freezed,
    Object? averageSleep30Days = freezed,
    Object? sleepTrend = freezed,
    Object? taskConsistencyPercentage = freezed,
  }) {
    return _then(_value.copyWith(
      randomMoment: freezed == randomMoment
          ? _value.randomMoment
          : randomMoment // ignore: cast_nullable_to_non_nullable
              as String?,
      randomMomentDate: freezed == randomMomentDate
          ? _value.randomMomentDate
          : randomMomentDate // ignore: cast_nullable_to_non_nullable
              as String?,
      averageSleep7Days: freezed == averageSleep7Days
          ? _value.averageSleep7Days
          : averageSleep7Days // ignore: cast_nullable_to_non_nullable
              as double?,
      averageSleep30Days: freezed == averageSleep30Days
          ? _value.averageSleep30Days
          : averageSleep30Days // ignore: cast_nullable_to_non_nullable
              as double?,
      sleepTrend: freezed == sleepTrend
          ? _value.sleepTrend
          : sleepTrend // ignore: cast_nullable_to_non_nullable
              as String?,
      taskConsistencyPercentage: freezed == taskConsistencyPercentage
          ? _value.taskConsistencyPercentage
          : taskConsistencyPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardSummaryImplCopyWith<$Res>
    implements $DashboardSummaryCopyWith<$Res> {
  factory _$$DashboardSummaryImplCopyWith(_$DashboardSummaryImpl value,
          $Res Function(_$DashboardSummaryImpl) then) =
      __$$DashboardSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'random_moment') String? randomMoment,
      @JsonKey(name: 'random_moment_date') String? randomMomentDate,
      @JsonKey(name: 'average_sleep_7_days') double? averageSleep7Days,
      @JsonKey(name: 'average_sleep_30_days') double? averageSleep30Days,
      @JsonKey(name: 'sleep_trend') String? sleepTrend,
      @JsonKey(name: 'task_consistency_percentage')
      double? taskConsistencyPercentage});
}

/// @nodoc
class __$$DashboardSummaryImplCopyWithImpl<$Res>
    extends _$DashboardSummaryCopyWithImpl<$Res, _$DashboardSummaryImpl>
    implements _$$DashboardSummaryImplCopyWith<$Res> {
  __$$DashboardSummaryImplCopyWithImpl(_$DashboardSummaryImpl _value,
      $Res Function(_$DashboardSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? randomMoment = freezed,
    Object? randomMomentDate = freezed,
    Object? averageSleep7Days = freezed,
    Object? averageSleep30Days = freezed,
    Object? sleepTrend = freezed,
    Object? taskConsistencyPercentage = freezed,
  }) {
    return _then(_$DashboardSummaryImpl(
      randomMoment: freezed == randomMoment
          ? _value.randomMoment
          : randomMoment // ignore: cast_nullable_to_non_nullable
              as String?,
      randomMomentDate: freezed == randomMomentDate
          ? _value.randomMomentDate
          : randomMomentDate // ignore: cast_nullable_to_non_nullable
              as String?,
      averageSleep7Days: freezed == averageSleep7Days
          ? _value.averageSleep7Days
          : averageSleep7Days // ignore: cast_nullable_to_non_nullable
              as double?,
      averageSleep30Days: freezed == averageSleep30Days
          ? _value.averageSleep30Days
          : averageSleep30Days // ignore: cast_nullable_to_non_nullable
              as double?,
      sleepTrend: freezed == sleepTrend
          ? _value.sleepTrend
          : sleepTrend // ignore: cast_nullable_to_non_nullable
              as String?,
      taskConsistencyPercentage: freezed == taskConsistencyPercentage
          ? _value.taskConsistencyPercentage
          : taskConsistencyPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardSummaryImpl implements _DashboardSummary {
  const _$DashboardSummaryImpl(
      {@JsonKey(name: 'random_moment') this.randomMoment,
      @JsonKey(name: 'random_moment_date') this.randomMomentDate,
      @JsonKey(name: 'average_sleep_7_days') this.averageSleep7Days,
      @JsonKey(name: 'average_sleep_30_days') this.averageSleep30Days,
      @JsonKey(name: 'sleep_trend') this.sleepTrend,
      @JsonKey(name: 'task_consistency_percentage')
      this.taskConsistencyPercentage});

  factory _$DashboardSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardSummaryImplFromJson(json);

  @override
  @JsonKey(name: 'random_moment')
  final String? randomMoment;
  @override
  @JsonKey(name: 'random_moment_date')
  final String? randomMomentDate;
  @override
  @JsonKey(name: 'average_sleep_7_days')
  final double? averageSleep7Days;
  @override
  @JsonKey(name: 'average_sleep_30_days')
  final double? averageSleep30Days;
  @override
  @JsonKey(name: 'sleep_trend')
  final String? sleepTrend;
// 'up', 'down', 'stable'
  @override
  @JsonKey(name: 'task_consistency_percentage')
  final double? taskConsistencyPercentage;

  @override
  String toString() {
    return 'DashboardSummary(randomMoment: $randomMoment, randomMomentDate: $randomMomentDate, averageSleep7Days: $averageSleep7Days, averageSleep30Days: $averageSleep30Days, sleepTrend: $sleepTrend, taskConsistencyPercentage: $taskConsistencyPercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardSummaryImpl &&
            (identical(other.randomMoment, randomMoment) ||
                other.randomMoment == randomMoment) &&
            (identical(other.randomMomentDate, randomMomentDate) ||
                other.randomMomentDate == randomMomentDate) &&
            (identical(other.averageSleep7Days, averageSleep7Days) ||
                other.averageSleep7Days == averageSleep7Days) &&
            (identical(other.averageSleep30Days, averageSleep30Days) ||
                other.averageSleep30Days == averageSleep30Days) &&
            (identical(other.sleepTrend, sleepTrend) ||
                other.sleepTrend == sleepTrend) &&
            (identical(other.taskConsistencyPercentage,
                    taskConsistencyPercentage) ||
                other.taskConsistencyPercentage == taskConsistencyPercentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      randomMoment,
      randomMomentDate,
      averageSleep7Days,
      averageSleep30Days,
      sleepTrend,
      taskConsistencyPercentage);

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardSummaryImplCopyWith<_$DashboardSummaryImpl> get copyWith =>
      __$$DashboardSummaryImplCopyWithImpl<_$DashboardSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardSummaryImplToJson(
      this,
    );
  }
}

abstract class _DashboardSummary implements DashboardSummary {
  const factory _DashboardSummary(
      {@JsonKey(name: 'random_moment') final String? randomMoment,
      @JsonKey(name: 'random_moment_date') final String? randomMomentDate,
      @JsonKey(name: 'average_sleep_7_days') final double? averageSleep7Days,
      @JsonKey(name: 'average_sleep_30_days') final double? averageSleep30Days,
      @JsonKey(name: 'sleep_trend') final String? sleepTrend,
      @JsonKey(name: 'task_consistency_percentage')
      final double? taskConsistencyPercentage}) = _$DashboardSummaryImpl;

  factory _DashboardSummary.fromJson(Map<String, dynamic> json) =
      _$DashboardSummaryImpl.fromJson;

  @override
  @JsonKey(name: 'random_moment')
  String? get randomMoment;
  @override
  @JsonKey(name: 'random_moment_date')
  String? get randomMomentDate;
  @override
  @JsonKey(name: 'average_sleep_7_days')
  double? get averageSleep7Days;
  @override
  @JsonKey(name: 'average_sleep_30_days')
  double? get averageSleep30Days;
  @override
  @JsonKey(name: 'sleep_trend')
  String? get sleepTrend; // 'up', 'down', 'stable'
  @override
  @JsonKey(name: 'task_consistency_percentage')
  double? get taskConsistencyPercentage;

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardSummaryImplCopyWith<_$DashboardSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
