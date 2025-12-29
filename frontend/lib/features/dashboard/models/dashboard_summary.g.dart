// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardSummaryImpl _$$DashboardSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardSummaryImpl(
      randomPastMoment: json['random_past_moment'] as String?,
      averageSleep7Days: (json['average_sleep_7_days'] as num?)?.toDouble(),
      averageSleep30Days: (json['average_sleep_30_days'] as num?)?.toDouble(),
      taskConsistencyPercentage:
          (json['task_consistency_percentage'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$DashboardSummaryImplToJson(
        _$DashboardSummaryImpl instance) =>
    <String, dynamic>{
      'random_past_moment': instance.randomPastMoment,
      'average_sleep_7_days': instance.averageSleep7Days,
      'average_sleep_30_days': instance.averageSleep30Days,
      'task_consistency_percentage': instance.taskConsistencyPercentage,
    };
