import '../../../../core/resources/data_state.dart';
import '../repository/movie_repository.dart';

class ToggleFavoriteUseCase {
  final MovieRepository _movieRepository;

  ToggleFavoriteUseCase(this._movieRepository);

  Future<DataState<void>> call(String movieId) async {
    return await _movieRepository.toggleFavorite(movieId);
  }
}
