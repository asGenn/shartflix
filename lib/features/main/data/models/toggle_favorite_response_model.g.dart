// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_favorite_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToggleFavoriteDataModel _$ToggleFavoriteDataModelFromJson(
  Map<String, dynamic> json,
) => ToggleFavoriteDataModel(
  movie: MovieModel.fromJson(json['movie'] as Map<String, dynamic>),
  action: json['action'] as String,
);

Map<String, dynamic> _$ToggleFavoriteDataModelToJson(
  ToggleFavoriteDataModel instance,
) => <String, dynamic>{'movie': instance.movie, 'action': instance.action};
