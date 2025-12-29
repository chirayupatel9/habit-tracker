// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MonthlyAggregationImpl _$$MonthlyAggregationImplFromJson(
        Map<String, dynamic> json) =>
    _$MonthlyAggregationImpl(
      date: json['date'] as String,
      momentOfDay: json['moment_of_day'] as String?,
      sleepHours: (json['sleep_hours'] as num?)?.toDouble(),
      dailyNote: json['daily_note'] as String?,
      taskCompletionCounts:
          (json['task_completion_counts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      averageSleep: (json['average_sleep'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$MonthlyAggregationImplToJson(
        _$MonthlyAggregationImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'moment_of_day': instance.momentOfDay,
      'sleep_hours': instance.sleepHours,
      'daily_note': instance.dailyNote,
      'task_completion_counts': instance.taskCompletionCounts,
      'average_sleep': instance.averageSleep,
    };
