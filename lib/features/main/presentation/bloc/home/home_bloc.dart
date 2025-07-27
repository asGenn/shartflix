import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../../domain/usecases/get_movies_use_case.dart';
import '../../../domain/usecases/toggle_favorite_use_case.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMoviesUseCase _getMoviesUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  HomeBloc(this._getMoviesUseCase, this._toggleFavoriteUseCase)
    : super(const HomeInitial()) {
    on<LoadMovies>(_onLoadMovies);
    on<LoadMoreMovies>(_onLoadMoreMovies);
    on<RefreshMovies>(_onRefreshMovies);
    on<PageChanged>(_onPageChanged);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadMovies(LoadMovies event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());

    await _analytics.logEvent(name: 'movies_loaded');

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

  void _onPageChanged(PageChanged event, Emitter<HomeState> emit) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(currentState.copyWith(currentIndex: event.index));

      // Son filme yaklaştığımızda daha fazla film yükle ki performansı arttır
      if (event.index >= currentState.movies.length - 2 &&
          !currentState.hasReachedMax) {
        add(const LoadMoreMovies());
      }
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final movieIndex = currentState.movies.indexWhere(
        (m) => m.id == event.movieId,
      );
      if (movieIndex == -1) return;

      final currentMovie = currentState.movies[movieIndex];

      await _analytics.logEvent(
        name: 'toggle_favorite',
        parameters: {
          'movie_id': event.movieId,
          'movie_title': currentMovie.title,
          'action': currentMovie.isFavorite ? 'remove' : 'add',
        },
      );

      final updatedMovies = List<MovieEntity>.from(currentState.movies);
      updatedMovies[movieIndex] = currentMovie.copyWithFavorite(
        !currentMovie.isFavorite,
      );
      emit(currentState.copyWith(movies: updatedMovies));

      final result = await _toggleFavoriteUseCase(event.movieId);

      if (result is DataFailed) {
        updatedMovies[movieIndex] = currentMovie;
        emit(currentState.copyWith(movies: updatedMovies));
        emit(HomeError(result.message ?? 'Favori işlemi başarısız'));
      }
    }
  }
}
