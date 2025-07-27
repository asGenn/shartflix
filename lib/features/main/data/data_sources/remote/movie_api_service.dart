import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/shared/models/base_response.dart';
import '../../../../../core/util/constants/network/remote.dart';
import '../../models/movie_model.dart';
import '../../models/movies_response_model.dart';
import '../../models/toggle_favorite_response_model.dart';

part 'movie_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class MovieApiService {
  factory MovieApiService(Dio dio) = _MovieApiService;

  @GET('/movie/list')
  Future<BaseResponse<MoviesDataModel>> getMovies({
    @Query('page') int page = 1,
  });

  @POST('/movie/favorite/{favoriteId}')
  Future<BaseResponse<ToggleFavoriteDataModel>> toggleFavorite(
    @Path('favoriteId') String movieId,
  );

  @GET('/movie/favorites')
  Future<BaseResponse<List<MovieModel>>> getFavoriteMovies();
}
