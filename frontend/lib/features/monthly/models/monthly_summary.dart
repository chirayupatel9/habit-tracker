import 'package:freezed_annotation/freezed_annotation.dart';

part 'monthly_summary.freezed.dart';
part 'monthly_summary.g.dart';

@freezed
class MonthlySummary with _$MonthlySummary {
  const factory MonthlySummary({
    required int year,
    required int month,
    @JsonKey(name: 'average_sleep') double? averageSleep,
    @JsonKey(name: 'task_completion_summary')
        Map<String, int>? taskCompletionSummary,
    @JsonKey(name: 'daily_notes')
        List<DailyNoteEntry>? dailyNotes,
    @JsonKey(name: 'random_moment') RandomMoment? randomMoment,
  }) = _MonthlySummary;

  factory MonthlySummary.fromJson(Map<String, dynamic> json) =>
      _$MonthlySummaryFromJson(json);
}

@freezed
class DailyNoteEntry with _$DailyNoteEntry {
  const factory DailyNoteEntry({
    required String date, // Format: YYYY-MM-DD
    String? note,
  }) = _DailyNoteEntry;

  factory DailyNoteEntry.fromJson(Map<String, dynamic> json) =>
      _$DailyNoteEntryFromJson(json);
}

@freezed
class RandomMoment with _$RandomMoment {
  const factory RandomMoment({
    required String date, // Format: YYYY-MM-DD
    required String moment,
  }) = _RandomMoment;

  factory RandomMoment.fromJson(Map<String, dynamic> json) =>
      _$RandomMomentFromJson(json);
}

