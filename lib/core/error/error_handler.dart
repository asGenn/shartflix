import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shartflix/core/error/error_type.dart';

class ErrorHandler {
  static AppError handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    }

    if (error is AppException) {
      return error.error;
    }

    return AppError(
      type: ErrorType.unexpected,
      message: _getErrorMessage(ErrorType.unexpected),
      details: error.toString(),
    );
  }

  static AppError _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.badResponse:
        return _handleHttpError(error);

      case DioExceptionType.unknown:
      default:
        if (error.message?.contains('SocketException') == true) {
          return AppError(
            type: ErrorType.noInternetConnection,
            message: 'errors.network_error'.tr(),
          );
        }
        return AppError(
          type: ErrorType.unknown,
          message: _getErrorMessage(ErrorType.unknown),
          details: error.message,
        );
    }
  }

  static AppError _handleHttpError(DioException error) {
    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;

    String? serverMessage;
    if (responseData is Map<String, dynamic>) {
      final rawMessage =
          responseData['response']?['message'] ??
          responseData['message'] ??
          responseData['error'];

      serverMessage = _translateServerMessage(rawMessage);
    }

    switch (statusCode) {
      case 400:
        return AppError(
          type: ErrorType.invalidCredentials,
          message:
              serverMessage ?? _getErrorMessage(ErrorType.invalidCredentials),
          statusCode: statusCode,
        );

      default:
        return AppError(
          type: ErrorType.unknown,
          message: _getErrorMessage(ErrorType.unknown),
          statusCode: statusCode,
        );
    }
  }

  static String _getErrorMessage(ErrorType errorType) {
    switch (errorType) {
      case ErrorType.invalidCredentials:
        return 'errors.invalid_credentials'.tr();
      case ErrorType.unknown:
      default:
        return 'errors.unknown_error'.tr();
    }
  }

  static String _translateServerMessage(String? rawMessage) {
    if (rawMessage == null) return 'errors.unknown_error'.tr();

    switch (rawMessage.toUpperCase()) {
      case 'INVALID_CREDENTIALS':
        return 'errors.invalid_credentials'.tr();
      default:
        return 'errors.general_error'.tr();
    }
  }
}
