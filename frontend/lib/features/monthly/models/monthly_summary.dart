import 'package:freezed_annotation/freezed_annotation.dart';

part 'monthly_summary.freezed.dart';
part 'monthly_summary.g.dart';

@freezed
class MonthlyAggregation with _$MonthlyAggregation {
  const factory MonthlyAggregation({
    required String date, // Format: YYYY-MM-DD
    @JsonKey(name: 'moment_of_day') String? momentOfDay,
    @JsonKey(name: 'sleep_hours') double? sleepHours,
    @JsonKey(name: 'daily_note') String? dailyNote,
    @JsonKey(name: 'task_completion_counts')
        Map<String, int>? taskCompletionCounts,
    @JsonKey(name: 'average_sleep') double? averageSleep,
  }) = _MonthlyAggregation;

  factory MonthlyAggregation.fromJson(Map<String, dynamic> json) =>
      _$MonthlyAggregationFromJson(json);
}

// Keep MonthlySummary for backward compatibility
typedef MonthlySummary = List<MonthlyAggregation>;

