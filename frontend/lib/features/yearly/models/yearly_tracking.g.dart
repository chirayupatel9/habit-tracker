// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yearly_tracking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$YearlyTrackingImpl _$$YearlyTrackingImplFromJson(Map<String, dynamic> json) =>
    _$YearlyTrackingImpl(
      year: (json['year'] as num).toInt(),
      trackedDates: (json['tracked_dates'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$YearlyTrackingImplToJson(
        _$YearlyTrackingImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'tracked_dates': instance.trackedDates,
    };
