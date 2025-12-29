import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_completion.freezed.dart';
part 'task_completion.g.dart';

@freezed
class TaskCompletion with _$TaskCompletion {
  const factory TaskCompletion({
    @JsonKey(name: 'task_id') required String taskId,
    required bool completed,
    String? feedback,
    @JsonKey(name: 'entry_id') String? entryId, // Only in response
  }) = _TaskCompletion;

  factory TaskCompletion.fromJson(Map<String, dynamic> json) =>
      _$TaskCompletionFromJson(json);
}

