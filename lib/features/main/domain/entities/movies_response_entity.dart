import 'package:equatable/equatable.dart';

import 'movie_entity.dart';
import 'pagination_entity.dart';

class MoviesDataEntity extends Equatable {
  final List<MovieEntity> movies;
  final PaginationEntity pagination;

  const MoviesDataEntity({required this.movies, required this.pagination});

  @override
  List<Object?> get props => [movies, pagination];
}
