// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardSummaryImpl _$$DashboardSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardSummaryImpl(
      randomMoment: json['random_moment'] as String?,
      randomMomentDate: json['random_moment_date'] as String?,
      averageSleep7Days: (json['average_sleep_7_days'] as num?)?.toDouble(),
      averageSleep30Days: (json['average_sleep_30_days'] as num?)?.toDouble(),
      sleepTrend: json['sleep_trend'] as String?,
      taskConsistencyPercentage:
          (json['task_consistency_percentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$DashboardSummaryImplToJson(
        _$DashboardSummaryImpl instance) =>
    <String, dynamic>{
      'random_moment': instance.randomMoment,
      'random_moment_date': instance.randomMomentDate,
      'average_sleep_7_days': instance.averageSleep7Days,
      'average_sleep_30_days': instance.averageSleep30Days,
      'sleep_trend': instance.sleepTrend,
      'task_consistency_percentage': instance.taskConsistencyPercentage,
    };
