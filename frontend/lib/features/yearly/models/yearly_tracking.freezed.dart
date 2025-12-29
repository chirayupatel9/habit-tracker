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

YearlyTrackingItem _$YearlyTrackingItemFromJson(Map<String, dynamic> json) {
  return _YearlyTrackingItem.fromJson(json);
}

/// @nodoc
mixin _$YearlyTrackingItem {
  String get date => throw _privateConstructorUsedError; // Format: YYYY-MM-DD
  bool get tracked => throw _privateConstructorUsedError;

  /// Serializes this YearlyTrackingItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YearlyTrackingItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YearlyTrackingItemCopyWith<YearlyTrackingItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YearlyTrackingItemCopyWith<$Res> {
  factory $YearlyTrackingItemCopyWith(
          YearlyTrackingItem value, $Res Function(YearlyTrackingItem) then) =
      _$YearlyTrackingItemCopyWithImpl<$Res, YearlyTrackingItem>;
  @useResult
  $Res call({String date, bool tracked});
}

/// @nodoc
class _$YearlyTrackingItemCopyWithImpl<$Res, $Val extends YearlyTrackingItem>
    implements $YearlyTrackingItemCopyWith<$Res> {
  _$YearlyTrackingItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YearlyTrackingItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? tracked = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      tracked: null == tracked
          ? _value.tracked
          : tracked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$YearlyTrackingItemImplCopyWith<$Res>
    implements $YearlyTrackingItemCopyWith<$Res> {
  factory _$$YearlyTrackingItemImplCopyWith(_$YearlyTrackingItemImpl value,
          $Res Function(_$YearlyTrackingItemImpl) then) =
      __$$YearlyTrackingItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, bool tracked});
}

/// @nodoc
class __$$YearlyTrackingItemImplCopyWithImpl<$Res>
    extends _$YearlyTrackingItemCopyWithImpl<$Res, _$YearlyTrackingItemImpl>
    implements _$$YearlyTrackingItemImplCopyWith<$Res> {
  __$$YearlyTrackingItemImplCopyWithImpl(_$YearlyTrackingItemImpl _value,
      $Res Function(_$YearlyTrackingItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of YearlyTrackingItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? tracked = null,
  }) {
    return _then(_$YearlyTrackingItemImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      tracked: null == tracked
          ? _value.tracked
          : tracked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$YearlyTrackingItemImpl implements _YearlyTrackingItem {
  const _$YearlyTrackingItemImpl({required this.date, required this.tracked});

  factory _$YearlyTrackingItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$YearlyTrackingItemImplFromJson(json);

  @override
  final String date;
// Format: YYYY-MM-DD
  @override
  final bool tracked;

  @override
  String toString() {
    return 'YearlyTrackingItem(date: $date, tracked: $tracked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YearlyTrackingItemImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.tracked, tracked) || other.tracked == tracked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, tracked);

  /// Create a copy of YearlyTrackingItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YearlyTrackingItemImplCopyWith<_$YearlyTrackingItemImpl> get copyWith =>
      __$$YearlyTrackingItemImplCopyWithImpl<_$YearlyTrackingItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$YearlyTrackingItemImplToJson(
      this,
    );
  }
}

abstract class _YearlyTrackingItem implements YearlyTrackingItem {
  const factory _YearlyTrackingItem(
      {required final String date,
      required final bool tracked}) = _$YearlyTrackingItemImpl;

  factory _YearlyTrackingItem.fromJson(Map<String, dynamic> json) =
      _$YearlyTrackingItemImpl.fromJson;

  @override
  String get date; // Format: YYYY-MM-DD
  @override
  bool get tracked;

  /// Create a copy of YearlyTrackingItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YearlyTrackingItemImplCopyWith<_$YearlyTrackingItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
