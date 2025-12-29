// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyEntryImpl _$$DailyEntryImplFromJson(Map<String, dynamic> json) =>
    _$DailyEntryImpl(
      date: json['date'] as String,
      momentOfDay: json['momentOfDay'] as String?,
      sleepHours: (json['sleep_hours'] as num?)?.toDouble(),
      dailyNote: json['daily_note'] as String?,
      taskCompletions: (json['task_completions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ),
    );

Map<String, dynamic> _$$DailyEntryImplToJson(_$DailyEntryImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'momentOfDay': instance.momentOfDay,
      'sleep_hours': instance.sleepHours,
      'daily_note': instance.dailyNote,
      'task_completions': instance.taskCompletions,
    };
