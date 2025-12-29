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

  Future<AuthResponse> login(LoginRequest request) async {
    // Use the model's toJson to ensure correct format
    final requestBody = request.toJson();
    
    // Debug: Print what we're sending (remove in production)
    print('Login request body: $requestBody');
    
    final response = await _apiClient.post(
      '/auth/login',
      requestBody,
      requireAuth: false,
    );
    
    // Debug: Print response before parsing
    print('Login response: $response');
    
    try {
      return AuthResponse.fromJson(response);
    } catch (e) {
      print('Error parsing AuthResponse: $e');
      print('Response data: $response');
      rethrow;
    }
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    // Registration might use JSON, but check your backend
    final response = await _apiClient.post(
      '/auth/register',
      request.toJson(),
      requireAuth: false,
    );
    return AuthResponse.fromJson(response);
  }

  Future<void> logout() async {
    try {
      await _apiClient.post('/auth/logout', {}, requireAuth: true);
    } catch (_) {
      // Ignore errors on logout
    }
  }
}

