// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'yearly_tracking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

YearlyTracking _$YearlyTrackingFromJson(Map<String, dynamic> json) {
  return _YearlyTracking.fromJson(json);
}

/// @nodoc
mixin _$YearlyTracking {
  int get year => throw _privateConstructorUsedError;
  @JsonKey(name: 'tracked_dates')
  List<String> get trackedDates => throw _privateConstructorUsedError;

  /// Serializes this YearlyTracking to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YearlyTracking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YearlyTrackingCopyWith<YearlyTracking> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YearlyTrackingCopyWith<$Res> {
  factory $YearlyTrackingCopyWith(
          YearlyTracking value, $Res Function(YearlyTracking) then) =
      _$YearlyTrackingCopyWithImpl<$Res, YearlyTracking>;
  @useResult
  $Res call(
      {int year, @JsonKey(name: 'tracked_dates') List<String> trackedDates});
}

/// @nodoc
class _$YearlyTrackingCopyWithImpl<$Res, $Val extends YearlyTracking>
    implements $YearlyTrackingCopyWith<$Res> {
  _$YearlyTrackingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YearlyTracking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? trackedDates = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      trackedDates: null == trackedDates
          ? _value.trackedDates
          : trackedDates // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$YearlyTrackingImplCopyWith<$Res>
    implements $YearlyTrackingCopyWith<$Res> {
  factory _$$YearlyTrackingImplCopyWith(_$YearlyTrackingImpl value,
          $Res Function(_$YearlyTrackingImpl) then) =
      __$$YearlyTrackingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int year, @JsonKey(name: 'tracked_dates') List<String> trackedDates});
}

/// @nodoc
class __$$YearlyTrackingImplCopyWithImpl<$Res>
    extends _$YearlyTrackingCopyWithImpl<$Res, _$YearlyTrackingImpl>
    implements _$$YearlyTrackingImplCopyWith<$Res> {
  __$$YearlyTrackingImplCopyWithImpl(
      _$YearlyTrackingImpl _value, $Res Function(_$YearlyTrackingImpl) _then)
      : super(_value, _then);

  /// Create a copy of YearlyTracking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? trackedDates = null,
  }) {
    return _then(_$YearlyTrackingImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      trackedDates: null == trackedDates
          ? _value._trackedDates
          : trackedDates // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$YearlyTrackingImpl implements _YearlyTracking {
  const _$YearlyTrackingImpl(
      {required this.year,
      @JsonKey(name: 'tracked_dates') required final List<String> trackedDates})
      : _trackedDates = trackedDates;

  factory _$YearlyTrackingImpl.fromJson(Map<String, dynamic> json) =>
      _$$YearlyTrackingImplFromJson(json);

  @override
  final int year;
  final List<String> _trackedDates;
  @override
  @JsonKey(name: 'tracked_dates')
  List<String> get trackedDates {
    if (_trackedDates is EqualUnmodifiableListView) return _trackedDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trackedDates);
  }

  @override
  String toString() {
    return 'YearlyTracking(year: $year, trackedDates: $trackedDates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YearlyTrackingImpl &&
            (identical(other.year, year) || other.year == year) &&
            const DeepCollectionEquality()
                .equals(other._trackedDates, _trackedDates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, year, const DeepCollectionEquality().hash(_trackedDates));

  /// Create a copy of YearlyTracking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YearlyTrackingImplCopyWith<_$YearlyTrackingImpl> get copyWith =>
      __$$YearlyTrackingImplCopyWithImpl<_$YearlyTrackingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$YearlyTrackingImplToJson(
      this,
    );
  }
}

abstract class _YearlyTracking implements YearlyTracking {
  const factory _YearlyTracking(
      {required final int year,
      @JsonKey(name: 'tracked_dates')
      required final List<String> trackedDates}) = _$YearlyTrackingImpl;

  factory _YearlyTracking.fromJson(Map<String, dynamic> json) =
      _$YearlyTrackingImpl.fromJson;

  @override
  int get year;
  @override
  @JsonKey(name: 'tracked_dates')
  List<String> get trackedDates;

  /// Create a copy of YearlyTracking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YearlyTrackingImplCopyWith<_$YearlyTrackingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
