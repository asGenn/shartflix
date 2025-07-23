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
