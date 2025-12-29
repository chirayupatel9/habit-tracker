// ignore_for_file: invalid_annotation_target
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/api_client.dart';
import '../models/feedback_request.dart';

part 'feedback_service.g.dart';

@riverpod
FeedbackService feedbackService(FeedbackServiceRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return FeedbackService(apiClient);
}

class FeedbackService {
  final ApiClient _apiClient;

  FeedbackService(this._apiClient);

  /// Submit feedback
  Future<void> submitFeedback(FeedbackRequest request) async {
    await _apiClient.post(
      '/feedback',
      request.toJson(),
      requireAuth: true,
    );
  }
}

