import 'package:json_annotation/json_annotation.dart';

import 'movie_model.dart';

part 'toggle_favorite_response_model.g.dart';

@JsonSerializable()
class ToggleFavoriteDataModel {
  final MovieModel movie;
  final String action;

  const ToggleFavoriteDataModel({required this.movie, required this.action});

  factory ToggleFavoriteDataModel.fromJson(Map<String, dynamic> json) =>
      _$ToggleFavoriteDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ToggleFavoriteDataModelToJson(this);
}
