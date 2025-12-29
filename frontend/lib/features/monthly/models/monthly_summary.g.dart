// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MonthlySummaryImpl _$$MonthlySummaryImplFromJson(Map<String, dynamic> json) =>
    _$MonthlySummaryImpl(
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      averageSleep: (json['average_sleep'] as num?)?.toDouble(),
      taskCompletionSummary:
          (json['task_completion_summary'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      dailyNotes: (json['daily_notes'] as List<dynamic>?)
          ?.map((e) => DailyNoteEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      randomMoment: json['random_moment'] == null
          ? null
          : RandomMoment.fromJson(
              json['random_moment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MonthlySummaryImplToJson(
        _$MonthlySummaryImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'average_sleep': instance.averageSleep,
      'task_completion_summary': instance.taskCompletionSummary,
      'daily_notes': instance.dailyNotes,
      'random_moment': instance.randomMoment,
    };

_$DailyNoteEntryImpl _$$DailyNoteEntryImplFromJson(Map<String, dynamic> json) =>
    _$DailyNoteEntryImpl(
      date: json['date'] as String,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$DailyNoteEntryImplToJson(
        _$DailyNoteEntryImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'note': instance.note,
    };

_$RandomMomentImpl _$$RandomMomentImplFromJson(Map<String, dynamic> json) =>
    _$RandomMomentImpl(
      date: json['date'] as String,
      moment: json['moment'] as String,
    );

Map<String, dynamic> _$$RandomMomentImplToJson(_$RandomMomentImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'moment': instance.moment,
    };
