enum ErrorType {
  // Network Errors
  noInternetConnection,

  // Validation Errors
  invalidCredentials,

  // General Errors
  unexpected,
  unknown,
}

class AppError {
  final ErrorType type;
  final String message;
  final String? details;
  final int? statusCode;

  const AppError({
    required this.type,
    required this.message,
    this.details,
    this.statusCode,
  });

  @override
  String toString() => 'AppError(type: $type, message: $message)';
}

class AppException implements Exception {
  final AppError error;

  const AppException(this.error);

  @override
  String toString() => error.toString();
}
