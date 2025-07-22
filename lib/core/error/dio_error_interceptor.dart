import 'package:dio/dio.dart';
import 'error_handler.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appError = ErrorHandler.handleError(err);

    // Log error for debugging
    print('🔴 API Error: ${appError.type}');
    print('📝 Message: ${appError.message}');
    print('🔢 Status Code: ${appError.statusCode}');
    print('📋 Details: ${appError.details}');

    // Continue with the error
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('🚀 API Request: ${options.method} ${options.path}');
    print('📦 Data: ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      '✅ API Response: ${response.statusCode} ${response.requestOptions.path}',
    );
    handler.next(response);
  }
}
