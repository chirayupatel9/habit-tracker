// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_completion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskCompletionImpl _$$TaskCompletionImplFromJson(Map<String, dynamic> json) =>
    _$TaskCompletionImpl(
      taskId: json['task_id'] as String,
      completed: json['completed'] as bool,
      feedback: json['feedback'] as String?,
      entryId: json['entry_id'] as String?,
    );

Map<String, dynamic> _$$TaskCompletionImplToJson(
        _$TaskCompletionImpl instance) =>
    <String, dynamic>{
      'task_id': instance.taskId,
      'completed': instance.completed,
      'feedback': instance.feedback,
      'entry_id': instance.entryId,
    };
