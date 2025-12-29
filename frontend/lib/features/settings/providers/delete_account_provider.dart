import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/profile/services/profile_service.dart';
import '../../../features/profile/models/user_profile.dart';
import '../../../features/auth/providers/auth_providers.dart';

part 'delete_account_provider.g.dart';

/// Provider for deleting user account
@riverpod
class DeleteAccount extends _$DeleteAccount {
  @override
  FutureOr<void> build() async {
    // Initial state
  }

  Future<void> deleteAccount(String password) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(profileServiceProvider);
      final request = DeleteAccountRequest(password: password);
      await service.deleteAccount(request);
      
      // Clear auth state and logout
      await ref.read(authStateProvider.notifier).logout();
      
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

