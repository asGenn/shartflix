import 'package:dio/dio.dart';

import '../../../../core/resources/data_state.dart';
import '../../../auth/data/data_sources/local/secure_storage_service.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/entities/movies_response_entity.dart';
import '../../domain/repository/movie_repository.dart';
import '../data_sources/remote/movie_api_service.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieApiService _movieApiService;
  final AuthLocalStorage _authLocalStorage;
  final Dio _dio;

  MovieRepositoryImpl(this._movieApiService, this._authLocalStorage, this._dio);

  Future<void> _setAuthHeader() async {
    final token = await _authLocalStorage.getToken();
    if (token != null) {
      _dio.options.headers['Authorization'] = token;
    }
  }

  @override
  Future<DataState<MoviesDataEntity>> getMovies({int page = 1}) async {
    try {
      await _setAuthHeader();
      final response = await _movieApiService.getMovies(page: page);

      if (response.data != null) {
        return DataSuccess(response.data!.toEntity());
      } else {
        return const DataFailed('Veri bulunamadı');
      }
    } on DioException catch (e) {
      return DataFailed(e.message ?? 'Bilinmeyen hata');
    }
  }

  @override
  Future<DataState<bool>> toggleFavorite(String movieId) async {
    try {
      await _setAuthHeader();
      final response = await _movieApiService.toggleFavorite(movieId);

      if (response.data != null) {
        // action değerine göre favorited/unfavorited kontrolü
        final isFavorited = response.data!.action == 'favorited';
        return DataSuccess(isFavorited);
      } else {
        return const DataFailed('Favori işlemi başarısız');
      }
    } on DioException catch (e) {
      return DataFailed(e.message ?? 'Bilinmeyen hata');
    }
  }

  @override
  Future<DataState<List<MovieEntity>>> getFavoriteMovies() async {
    try {
      await _setAuthHeader();
      final response = await _movieApiService.getFavoriteMovies();

      if (response.data != null) {
        final movieEntities = response.data!
            .map((movieModel) => movieModel.toEntity())
            .toList();
        return DataSuccess(movieEntities);
      } else {
        return const DataFailed('Favori filmler bulunamadı');
      }
    } on DioException catch (e) {
      return DataFailed(e.message ?? 'Bilinmeyen hata');
    }
  }
}
