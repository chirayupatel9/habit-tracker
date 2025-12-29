import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/profile_service.dart';
import '../models/user_profile.dart';

part 'change_password_provider.g.dart';

/// Provider for changing user password
@riverpod
class ChangePassword extends _$ChangePassword {
  @override
  FutureOr<void> build() async {
    // Initial state
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(profileServiceProvider);
      final request = ChangePasswordRequest(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      await service.changePassword(request);
      
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

