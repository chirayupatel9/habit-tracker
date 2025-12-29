// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyEntryImpl _$$DailyEntryImplFromJson(Map<String, dynamic> json) =>
    _$DailyEntryImpl(
      date: json['date'] as String,
      momentOfDay: json['moment_of_day'] as String?,
      sleepHours: (json['sleep_hours'] as num?)?.toDouble(),
      dailyNote: json['daily_note'] as String?,
      taskCompletions: (json['task_completions'] as List<dynamic>?)
              ?.map((e) => TaskCompletion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$DailyEntryImplToJson(_$DailyEntryImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'moment_of_day': instance.momentOfDay,
      'sleep_hours': instance.sleepHours,
      'daily_note': instance.dailyNote,
      'task_completions': instance.taskCompletions,
      'id': instance.id,
      'user_id': instance.userId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
