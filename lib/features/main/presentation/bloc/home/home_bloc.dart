import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../../domain/usecases/get_movies_use_case.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMoviesUseCase _getMoviesUseCase;

  HomeBloc(this._getMoviesUseCase) : super(const HomeInitial()) {
    on<LoadMovies>(_onLoadMovies);
    on<LoadMoreMovies>(_onLoadMoreMovies);
    on<RefreshMovies>(_onRefreshMovies);
  }

  Future<void> _onLoadMovies(LoadMovies event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());

    final result = await _getMoviesUseCase(const GetMoviesParams(page: 1));

    if (result is DataSuccess) {
      final moviesData = result.data!;
      final hasReachedMax =
          moviesData.pagination.currentPage >= moviesData.pagination.maxPage;
      emit(
        HomeLoaded(
          movies: moviesData.movies,
          hasReachedMax: hasReachedMax,
          currentPage: moviesData.pagination.currentPage,
        ),
      );
    } else if (result is DataFailed) {
      emit(HomeError(result.message ?? 'Filmler yüklenirken hata oluştu'));
    }
  }

  Future<void> _onLoadMoreMovies(
    LoadMoreMovies event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is! HomeLoaded ||
        currentState.hasReachedMax ||
        currentState.isLoadingMore) {
      return;
    }

    // Loading more indicator'ı göster
    emit(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.currentPage + 1;
    final result = await _getMoviesUseCase(GetMoviesParams(page: nextPage));

    if (result is DataSuccess) {
      final moviesData = result.data!;
      final hasReachedMax =
          moviesData.pagination.currentPage >= moviesData.pagination.maxPage;
      final allMovies = List<MovieEntity>.from(currentState.movies)
        ..addAll(moviesData.movies);

      emit(
        HomeLoaded(
          movies: allMovies,
          hasReachedMax: hasReachedMax,
          currentPage: moviesData.pagination.currentPage,
          isLoadingMore: false,
        ),
      );
    } else if (result is DataFailed) {
      emit(currentState.copyWith(isLoadingMore: false));
      emit(
        HomeError(result.message ?? 'Daha fazla film yüklenirken hata oluştu'),
      );
    }
  }

  Future<void> _onRefreshMovies(
    RefreshMovies event,
    Emitter<HomeState> emit,
  ) async {
    add(const LoadMovies());
  }
}
