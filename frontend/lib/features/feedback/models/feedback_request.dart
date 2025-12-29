import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_request.freezed.dart';
part 'feedback_request.g.dart';

@freezed
class FeedbackRequest with _$FeedbackRequest {
  const factory FeedbackRequest({
    required int rating, // 1-5
    required String message,
  }) = _FeedbackRequest;

  factory FeedbackRequest.fromJson(Map<String, dynamic> json) =>
      _$FeedbackRequestFromJson(json);
}

