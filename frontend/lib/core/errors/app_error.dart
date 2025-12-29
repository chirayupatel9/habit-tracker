import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

/// Sealed class for app-level errors
@freezed
class AppError with _$AppError {
  const AppError._();

  const factory AppError.network({
    required String message,
  }) = NetworkError;

  const factory AppError.unauthorized({
    required String message,
  }) = UnauthorizedError;

  const factory AppError.validation({
    required String message,
    Map<String, dynamic>? details,
  }) = ValidationError;

  const factory AppError.notFound({
    required String message,
  }) = NotFoundError;

  const factory AppError.server({
    required String message,
  }) = ServerError;

  const factory AppError.unknown({
    required String message,
  }) = UnknownError;

  /// Get user-friendly error message
  String get userMessage {
    return when(
      network: (message) => 'Network error. Please check your connection.',
      unauthorized: (message) => 'Session expired. Please login again.',
      validation: (message, details) => message,
      notFound: (message) => 'Resource not found.',
      server: (message) => 'Server error. Please try again later.',
      unknown: (message) => 'An unexpected error occurred.',
    );
  }

  /// Get error title for UI
  String get title {
    return when(
      network: (_) => 'Connection Error',
      unauthorized: (_) => 'Authentication Required',
      validation: (_, __) => 'Validation Error',
      notFound: (_) => 'Not Found',
      server: (_) => 'Server Error',
      unknown: (_) => 'Error',
    );
  }
}

