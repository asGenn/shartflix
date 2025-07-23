// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesDataModel _$MoviesDataModelFromJson(Map<String, dynamic> json) =>
    MoviesDataModel(
      movies: (json['movies'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: PaginationModel.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$MoviesDataModelToJson(MoviesDataModel instance) =>
    <String, dynamic>{
      'movies': instance.movies,
      'pagination': instance.pagination,
    };
