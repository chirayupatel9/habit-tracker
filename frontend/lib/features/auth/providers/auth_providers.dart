// ignore_for_file: invalid_annotation_target
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/secure_storage.dart';
import '../models/auth_models.dart';
import '../services/auth_service.dart';

part 'auth_providers.g.dart';

// Keep AuthResponse for backward compatibility, but use TokenResponse
typedef AuthResponse = TokenResponse;

@riverpod
class AuthState extends _$AuthState {
  @override
  FutureOr<bool> build() async {
    final token = await ref.read(secureStorageProvider).getAccessToken();
    return token != null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final authService = ref.read(authServiceProvider);
      final request = LoginRequest(email: email, password: password);
      final response = await authService.login(request);

      final secureStorage = ref.read(secureStorageProvider);
      await secureStorage.saveAccessToken(response.accessToken);
      await secureStorage.saveRefreshToken(response.refreshToken);

      state = const AsyncValue.data(true);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> register(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final authService = ref.read(authServiceProvider);
      final request = RegisterRequest(
        email: email,
        password: password,
      );
      // Register returns UserResponse, then we need to login to get tokens
      await authService.register(request);
      
      // After successful registration, automatically login
      await login(email, password);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      final authService = ref.read(authServiceProvider);
      await authService.logout();
    } catch (_) {
      // Ignore logout errors
    } finally {
      final secureStorage = ref.read(secureStorageProvider);
      await secureStorage.clearAll();
      state = const AsyncValue.data(false);
    }
  }

  Future<void> checkAuth() async {
    final token = await ref.read(secureStorageProvider).getAccessToken();
    state = AsyncValue.data(token != null);
  }
}

