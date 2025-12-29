// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedbackRequestImpl _$$FeedbackRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$FeedbackRequestImpl(
      rating: (json['rating'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$$FeedbackRequestImplToJson(
        _$FeedbackRequestImpl instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'message': instance.message,
    };
