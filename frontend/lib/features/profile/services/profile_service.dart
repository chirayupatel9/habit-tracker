// ignore_for_file: invalid_annotation_target
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/api_client.dart';
import '../models/user_profile.dart';

part 'profile_service.g.dart';

@riverpod
ProfileService profileService(ProfileServiceRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProfileService(apiClient);
}

class ProfileService {
  final ApiClient _apiClient;

  ProfileService(this._apiClient);

  Future<UserProfile> getUserProfile() async {
    final response = await _apiClient.get(
      '/users/me',
      requireAuth: true,
    );
    return UserProfile.fromJson(response);
  }

  Future<UserProfile> updateProfile(UpdateProfileRequest request) async {
    final response = await _apiClient.put(
      '/users/me',
      request.toJson(),
      requireAuth: true,
    );
    return UserProfile.fromJson(response);
  }

  Future<void> changePassword(ChangePasswordRequest request) async {
    await _apiClient.put(
      '/users/me/password',
      request.toJson(),
      requireAuth: true,
    );
  }

  Future<void> deleteAccount(DeleteAccountRequest request) async {
    await _apiClient.delete(
      '/users/me',
      requireAuth: true,
      body: request.toJson(),
    );
  }
}

