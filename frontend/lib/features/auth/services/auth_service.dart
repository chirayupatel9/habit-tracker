// ignore_for_file: invalid_annotation_target
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/api_client.dart';
import '../models/auth_models.dart';

part 'auth_service.g.dart';

@riverpod
AuthService authService(AuthServiceRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthService(apiClient);
}

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  Future<TokenResponse> login(LoginRequest request) async {
    final response = await _apiClient.post(
      '/auth/login',
      request.toJson(),
      requireAuth: false,
    );
    return TokenResponse.fromJson(response);
  }

  Future<UserResponse> register(RegisterRequest request) async {
    final response = await _apiClient.post(
      '/auth/register',
      request.toJson(),
      requireAuth: false,
    );
    return UserResponse.fromJson(response);
  }

  Future<void> logout() async {
    try {
      await _apiClient.post('/auth/logout', {}, requireAuth: true);
    } catch (_) {
      // Ignore errors on logout
    }
  }
}

