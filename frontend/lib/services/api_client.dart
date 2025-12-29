// ignore_for_file: invalid_annotation_target
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../core/constants/app_constants.dart';
import 'secure_storage.dart';

part 'api_client.g.dart';

enum ApiErrorType {
  network,
  server,
  unauthorized,
  notFound,
  validation,
  unknown,
}

class ApiException implements Exception {
  final String message;
  final ApiErrorType type;
  final int? statusCode;

  ApiException({
    required this.message,
    required this.type,
    this.statusCode,
  });

  @override
  String toString() => message;
}

@riverpod
ApiClient apiClient(ApiClientRef ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return ApiClient(secureStorage);
}

class ApiClient {
  final SecureStorageService _secureStorage;
  final String _baseUrl;

  ApiClient(this._secureStorage, {String? baseUrl})
      : _baseUrl = baseUrl ?? AppConstants.baseUrl;

  Future<Map<String, String>> _getHeaders({bool includeAuth = true}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (includeAuth) {
      final token = await _secureStorage.getAccessToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    bool requireAuth = true,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await http
          .get(
            uri,
            headers: await _getHeaders(includeAuth: requireAuth),
          )
          .timeout(AppConstants.connectionTimeout);

      return _handleResponse(response);
    } on http.ClientException {
      throw ApiException(
        message: 'Network error. Please check your connection.',
        type: ApiErrorType.network,
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        message: 'An unexpected error occurred',
        type: ApiErrorType.unknown,
      );
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    bool requireAuth = false,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await http
          .post(
            uri,
            headers: await _getHeaders(includeAuth: requireAuth),
            body: jsonEncode(body),
          )
          .timeout(AppConstants.connectionTimeout);

      return _handleResponse(response);
    } on http.ClientException {
      throw ApiException(
        message: 'Network error. Please check your connection.',
        type: ApiErrorType.network,
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        message: 'An unexpected error occurred',
        type: ApiErrorType.unknown,
      );
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> body, {
    bool requireAuth = true,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await http
          .put(
            uri,
            headers: await _getHeaders(includeAuth: requireAuth),
            body: jsonEncode(body),
          )
          .timeout(AppConstants.connectionTimeout);

      return _handleResponse(response);
    } on http.ClientException {
      throw ApiException(
        message: 'Network error. Please check your connection.',
        type: ApiErrorType.network,
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        message: 'An unexpected error occurred',
        type: ApiErrorType.unknown,
      );
    }
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    bool requireAuth = true,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await http
          .delete(
            uri,
            headers: await _getHeaders(includeAuth: requireAuth),
          )
          .timeout(AppConstants.connectionTimeout);

      return _handleResponse(response);
    } on http.ClientException {
      throw ApiException(
        message: 'Network error. Please check your connection.',
        type: ApiErrorType.network,
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        message: 'An unexpected error occurred',
        type: ApiErrorType.unknown,
      );
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {};
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    String errorMessage = 'An error occurred';
    ApiErrorType errorType = ApiErrorType.unknown;

    try {
      final errorBody = jsonDecode(response.body) as Map<String, dynamic>;
      errorMessage = errorBody['detail'] as String? ??
          errorBody['message'] as String? ??
          errorMessage;
    } catch (_) {
      errorMessage = response.body.isNotEmpty
          ? response.body
          : 'HTTP ${response.statusCode}';
    }

    switch (response.statusCode) {
      case 401:
        errorType = ApiErrorType.unauthorized;
        errorMessage = errorMessage.isEmpty
            ? 'Unauthorized. Please login again.'
            : errorMessage;
        break;
      case 404:
        errorType = ApiErrorType.notFound;
        break;
      case 400:
      case 422:
        errorType = ApiErrorType.validation;
        break;
      case 500:
      case 502:
      case 503:
        errorType = ApiErrorType.server;
        errorMessage = 'Server error. Please try again later.';
        break;
      default:
        errorType = ApiErrorType.unknown;
    }

    throw ApiException(
      message: errorMessage,
      type: errorType,
      statusCode: response.statusCode,
    );
  }
}

