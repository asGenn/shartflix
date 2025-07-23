import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/movie_entity.dart';
import '../repository/movie_repository.dart';

class GetFavoriteMoviesUseCase
    implements UseCase<DataState<List<MovieEntity>>, NoParams> {
  final MovieRepository _movieRepository;

  GetFavoriteMoviesUseCase(this._movieRepository);

  @override
  Future<DataState<List<MovieEntity>>> call(NoParams params) async {
    return await _movieRepository.getFavoriteMovies();
  }
}

class NoParams {
  const NoParams();
}
