import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_entry.freezed.dart';
part 'daily_entry.g.dart';

@freezed
class DailyEntry with _$DailyEntry {
  const factory DailyEntry({
    required String date, // Format: YYYY-MM-DD
    String? momentOfDay,
    @JsonKey(name: 'sleep_hours') double? sleepHours,
    @JsonKey(name: 'daily_note') String? dailyNote,
    @JsonKey(name: 'task_completions')
        Map<String, bool>? taskCompletions,
  }) = _DailyEntry;

  factory DailyEntry.fromJson(Map<String, dynamic> json) =>
      _$DailyEntryFromJson(json);
}

