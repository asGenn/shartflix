import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_response.dart';
import '../../domain/entities/movies_response_entity.dart';
import 'movie_model.dart';
import 'pagination_model.dart';

part 'movies_response_model.g.dart';

@JsonSerializable()
class MoviesDataModel {
  final List<MovieModel> movies;
  final PaginationModel pagination;

  const MoviesDataModel({required this.movies, required this.pagination});

  factory MoviesDataModel.fromJson(Map<String, dynamic> json) =>
      _$MoviesDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$MoviesDataModelToJson(this);

  MoviesDataEntity toEntity() {
    return MoviesDataEntity(
      movies: movies.map((movie) => movie.toEntity()).toList(),
      pagination: pagination.toEntity(),
    );
  }
}

// BaseResponse<MoviesDataModel> olarak kullanılacak
typedef MoviesResponseModel = BaseResponse<MoviesDataModel>;
