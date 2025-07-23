import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/movie_entity.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  @JsonKey(name: '_id')
  final String mongoId;
  final String id;
  @JsonKey(name: 'Title')
  final String title;
  @JsonKey(name: 'Year')
  final String year;
  @JsonKey(name: 'Rated')
  final String rated;
  @JsonKey(name: 'Released')
  final String released;
  @JsonKey(name: 'Runtime')
  final String runtime;
  @JsonKey(name: 'Genre')
  final String genre;
  @JsonKey(name: 'Director')
  final String director;
  @JsonKey(name: 'Writer')
  final String writer;
  @JsonKey(name: 'Actors')
  final String actors;
  @JsonKey(name: 'Plot')
  final String plot;
  @JsonKey(name: 'Language')
  final String language;
  @JsonKey(name: 'Country')
  final String country;
  @JsonKey(name: 'Awards')
  final String awards;
  @JsonKey(name: 'Poster')
  final String poster;
  @JsonKey(name: 'Metascore')
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbID;
  @JsonKey(name: 'Type')
  final String type;
  @JsonKey(name: 'Response')
  final String response;
  @JsonKey(name: 'Images')
  final List<String> images;
  @JsonKey(name: 'ComingSoon')
  final bool comingSoon;
  final bool isFavorite;

  const MovieModel({
    required this.mongoId,
    required this.id,
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbID,
    required this.type,
    required this.response,
    required this.images,
    required this.comingSoon,
    required this.isFavorite,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      year: year,
      rated: rated,
      released: released,
      runtime: runtime,
      genre: genre,
      director: director,
      writer: writer,
      actors: actors,
      plot: plot,
      language: language,
      country: country,
      awards: awards,
      poster: poster,
      metascore: metascore,
      imdbRating: imdbRating,
      imdbVotes: imdbVotes,
      imdbID: imdbID,
      type: type,
      response: response,
      images: images,
      comingSoon: comingSoon,
      isFavorite: isFavorite,
    );
  }
}
