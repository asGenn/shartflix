import 'package:shartflix/core/error/error_handler.dart';
import 'package:shartflix/core/resources/data_state.dart';

mixin class BaseRepository {
  Future<DataState<T>> handleApiCall<T>(Future<T> Function() apiCall) async {
    try {
      final result = await apiCall();
      return DataSuccess(result);
    } catch (error) {
      final appError = ErrorHandler.handleError(error);
      return DataFailed(appError.message);
    }
  }
}
