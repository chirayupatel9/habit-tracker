import '../../services/api_client.dart';
import 'app_error.dart';

/// Maps API exceptions to AppError
class ErrorMapper {
  static AppError fromApiException(ApiException exception) {
    switch (exception.type) {
      case ApiErrorType.network:
        return AppError.network(message: exception.message);
      case ApiErrorType.unauthorized:
        return AppError.unauthorized(message: exception.message);
      case ApiErrorType.validation:
        return AppError.validation(message: exception.message);
      case ApiErrorType.notFound:
        return AppError.notFound(message: exception.message);
      case ApiErrorType.server:
        return AppError.server(message: exception.message);
      case ApiErrorType.unknown:
      default:
        return AppError.unknown(message: exception.message);
    }
  }

  static AppError fromException(Exception exception) {
    if (exception is ApiException) {
      return fromApiException(exception);
    }
    return AppError.unknown(message: exception.toString());
  }
}

