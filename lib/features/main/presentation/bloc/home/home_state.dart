import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<MovieEntity> movies;
  final bool hasReachedMax;
  final int currentPage;
  final bool isLoadingMore;

  const HomeLoaded({
    required this.movies,
    required this.hasReachedMax,
    required this.currentPage,
    this.isLoadingMore = false,
  });

  @override
  List<Object> get props => [movies, hasReachedMax, currentPage, isLoadingMore];

  HomeLoaded copyWith({
    List<MovieEntity>? movies,
    bool? hasReachedMax,
    int? currentPage,
    bool? isLoadingMore,
  }) {
    return HomeLoaded(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
