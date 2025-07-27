import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../shared/services/logger_service.dart';
import 'error_handler.dart';

class DioErrorInterceptor extends Interceptor {
  final LoggerService _logger = GetIt.instance<LoggerService>();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appError = ErrorHandler.handleError(err);

    _logger.error(
      'API Error: ${appError.type}',
      'Message: ${appError.message}\nStatus Code: ${appError.statusCode}\nDetails: ${appError.details}',
    );

    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.info(
      'API Request: ${options.method} ${options.path}',
      'Data: ${options.data}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.info(
      'API Response: ${response.statusCode} ${response.requestOptions.path}',
    );
    handler.next(response);
  }
}
