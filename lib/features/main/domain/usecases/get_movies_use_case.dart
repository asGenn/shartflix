import '../../../../core/resources/data_state.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../entities/movies_response_entity.dart';
import '../repository/movie_repository.dart';

class GetMoviesUseCase
    implements UseCase<DataState<MoviesDataEntity>, GetMoviesParams> {
  final MovieRepository _movieRepository;

  GetMoviesUseCase(this._movieRepository);

  @override
  Future<DataState<MoviesDataEntity>> call(GetMoviesParams params) async {
    return await _movieRepository.getMovies(page: params.page);
  }
}

class GetMoviesParams {
  final int page;

  const GetMoviesParams({this.page = 1});
}
