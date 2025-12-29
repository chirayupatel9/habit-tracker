import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user_profile.dart';
import '../services/profile_service.dart';

part 'profile_providers.g.dart';

/// Provider for user profile data
@riverpod
Future<UserProfile> userProfile(UserProfileRef ref) async {
  final service = ref.watch(profileServiceProvider);
  return await service.getUserProfile();
}

/// Provider for updating user profile
@riverpod
class UpdateProfile extends _$UpdateProfile {
  @override
  FutureOr<void> build() async {
    // Initial state
  }

  Future<UserProfile> updateProfile(String email) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(profileServiceProvider);
      final request = UpdateProfileRequest(email: email);
      final updatedProfile = await service.updateProfile(request);
      
      // Invalidate userProfileProvider to refresh profile data
      ref.invalidate(userProfileProvider);
      
      state = const AsyncValue.data(null);
      return updatedProfile;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

