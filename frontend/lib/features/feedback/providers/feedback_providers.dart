import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/feedback_request.dart';
import '../services/feedback_service.dart';

part 'feedback_providers.g.dart';

/// Provider for submitting feedback
@riverpod
class SubmitFeedback extends _$SubmitFeedback {
  @override
  FutureOr<void> build() async {
    // Initial state
  }

  Future<void> submitFeedback(int rating, String message) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(feedbackServiceProvider);
      final request = FeedbackRequest(rating: rating, message: message);
      await service.submitFeedback(request);
      
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

