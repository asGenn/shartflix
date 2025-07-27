import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadMovies extends HomeEvent {
  const LoadMovies();
}

class LoadMoreMovies extends HomeEvent {
  const LoadMoreMovies();
}

class RefreshMovies extends HomeEvent {
  const RefreshMovies();
}

class PageChanged extends HomeEvent {
  final int index;

  const PageChanged(this.index);

  @override
  List<Object> get props => [index];
}

class ToggleFavorite extends HomeEvent {
  final String movieId;

  const ToggleFavorite(this.movieId);

  @override
  List<Object> get props => [movieId];
}
