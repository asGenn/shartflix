import '../../../../core/resources/data_state.dart';
import '../entities/movie_entity.dart';
import '../entities/movies_response_entity.dart';

abstract class MovieRepository {
  Future<DataState<MoviesDataEntity>> getMovies({int page = 1});

  Future<DataState<bool>> toggleFavorite(String movieId);

  Future<DataState<List<MovieEntity>>> getFavoriteMovies();
}
