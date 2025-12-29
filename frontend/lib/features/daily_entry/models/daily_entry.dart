import 'package:freezed_annotation/freezed_annotation.dart';
import 'task_completion.dart';

part 'daily_entry.freezed.dart';
part 'daily_entry.g.dart';

@freezed
class DailyEntry with _$DailyEntry {
  const factory DailyEntry({
    required String date, // Format: YYYY-MM-DD
    @JsonKey(name: 'moment_of_day') String? momentOfDay,
    @JsonKey(name: 'sleep_hours') double? sleepHours,
    @JsonKey(name: 'daily_note') String? dailyNote,
    @JsonKey(name: 'task_completions')
        @Default([]) List<TaskCompletion> taskCompletions,
    // Response-only fields
    String? id,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _DailyEntry;

  factory DailyEntry.fromJson(Map<String, dynamic> json) =>
      _$DailyEntryFromJson(json);
}

