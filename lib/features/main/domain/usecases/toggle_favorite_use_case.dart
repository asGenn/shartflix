import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/movie_repository.dart';

class ToggleFavoriteUseCase
    implements UseCase<DataState<bool>, ToggleFavoriteParams> {
  final MovieRepository _movieRepository;

  ToggleFavoriteUseCase(this._movieRepository);

  @override
  Future<DataState<bool>> call(ToggleFavoriteParams params) async {
    return await _movieRepository.toggleFavorite(params.movieId);
  }
}

class ToggleFavoriteParams {
  final String movieId;

  const ToggleFavoriteParams({required this.movieId});
}
