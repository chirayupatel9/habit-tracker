import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_summary.freezed.dart';
part 'dashboard_summary.g.dart';

@freezed
class DashboardSummary with _$DashboardSummary {
  const factory DashboardSummary({
    @JsonKey(name: 'random_moment') String? randomMoment,
    @JsonKey(name: 'random_moment_date') String? randomMomentDate,
    @JsonKey(name: 'average_sleep_7_days') double? averageSleep7Days,
    @JsonKey(name: 'average_sleep_30_days') double? averageSleep30Days,
    @JsonKey(name: 'sleep_trend') String? sleepTrend, // 'up', 'down', 'stable'
    @JsonKey(name: 'task_consistency_percentage') double? taskConsistencyPercentage,
  }) = _DashboardSummary;

  factory DashboardSummary.fromJson(Map<String, dynamic> json) =>
      _$DashboardSummaryFromJson(json);
}

