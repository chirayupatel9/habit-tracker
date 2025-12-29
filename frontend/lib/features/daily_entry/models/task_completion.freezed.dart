// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_completion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskCompletion _$TaskCompletionFromJson(Map<String, dynamic> json) {
  return _TaskCompletion.fromJson(json);
}

/// @nodoc
mixin _$TaskCompletion {
  @JsonKey(name: 'task_id')
  String get taskId => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  String? get feedback => throw _privateConstructorUsedError;
  @JsonKey(name: 'entry_id')
  String? get entryId => throw _privateConstructorUsedError;

  /// Serializes this TaskCompletion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskCompletion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskCompletionCopyWith<TaskCompletion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCompletionCopyWith<$Res> {
  factory $TaskCompletionCopyWith(
          TaskCompletion value, $Res Function(TaskCompletion) then) =
      _$TaskCompletionCopyWithImpl<$Res, TaskCompletion>;
  @useResult
  $Res call(
      {@JsonKey(name: 'task_id') String taskId,
      bool completed,
      String? feedback,
      @JsonKey(name: 'entry_id') String? entryId});
}

/// @nodoc
class _$TaskCompletionCopyWithImpl<$Res, $Val extends TaskCompletion>
    implements $TaskCompletionCopyWith<$Res> {
  _$TaskCompletionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskCompletion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? completed = null,
    Object? feedback = freezed,
    Object? entryId = freezed,
  }) {
    return _then(_value.copyWith(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      entryId: freezed == entryId
          ? _value.entryId
          : entryId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskCompletionImplCopyWith<$Res>
    implements $TaskCompletionCopyWith<$Res> {
  factory _$$TaskCompletionImplCopyWith(_$TaskCompletionImpl value,
          $Res Function(_$TaskCompletionImpl) then) =
      __$$TaskCompletionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'task_id') String taskId,
      bool completed,
      String? feedback,
      @JsonKey(name: 'entry_id') String? entryId});
}

/// @nodoc
class __$$TaskCompletionImplCopyWithImpl<$Res>
    extends _$TaskCompletionCopyWithImpl<$Res, _$TaskCompletionImpl>
    implements _$$TaskCompletionImplCopyWith<$Res> {
  __$$TaskCompletionImplCopyWithImpl(
      _$TaskCompletionImpl _value, $Res Function(_$TaskCompletionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskCompletion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? completed = null,
    Object? feedback = freezed,
    Object? entryId = freezed,
  }) {
    return _then(_$TaskCompletionImpl(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      entryId: freezed == entryId
          ? _value.entryId
          : entryId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskCompletionImpl implements _TaskCompletion {
  const _$TaskCompletionImpl(
      {@JsonKey(name: 'task_id') required this.taskId,
      required this.completed,
      this.feedback,
      @JsonKey(name: 'entry_id') this.entryId});

  factory _$TaskCompletionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskCompletionImplFromJson(json);

  @override
  @JsonKey(name: 'task_id')
  final String taskId;
  @override
  final bool completed;
  @override
  final String? feedback;
  @override
  @JsonKey(name: 'entry_id')
  final String? entryId;

  @override
  String toString() {
    return 'TaskCompletion(taskId: $taskId, completed: $completed, feedback: $feedback, entryId: $entryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskCompletionImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            (identical(other.entryId, entryId) || other.entryId == entryId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, taskId, completed, feedback, entryId);

  /// Create a copy of TaskCompletion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskCompletionImplCopyWith<_$TaskCompletionImpl> get copyWith =>
      __$$TaskCompletionImplCopyWithImpl<_$TaskCompletionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskCompletionImplToJson(
      this,
    );
  }
}

abstract class _TaskCompletion implements TaskCompletion {
  const factory _TaskCompletion(
      {@JsonKey(name: 'task_id') required final String taskId,
      required final bool completed,
      final String? feedback,
      @JsonKey(name: 'entry_id') final String? entryId}) = _$TaskCompletionImpl;

  factory _TaskCompletion.fromJson(Map<String, dynamic> json) =
      _$TaskCompletionImpl.fromJson;

  @override
  @JsonKey(name: 'task_id')
  String get taskId;
  @override
  bool get completed;
  @override
  String? get feedback;
  @override
  @JsonKey(name: 'entry_id')
  String? get entryId;

  /// Create a copy of TaskCompletion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskCompletionImplCopyWith<_$TaskCompletionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
