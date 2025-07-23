import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String id;
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbID;
  final String type;
  final String response;
  final List<String> images;
  final bool comingSoon;
  final bool isFavorite;

  const MovieEntity({
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

  @override
  List<Object?> get props => [
    id,
    title,
    year,
    rated,
    released,
    runtime,
    genre,
    director,
    writer,
    actors,
    plot,
    language,
    country,
    awards,
    poster,
    metascore,
    imdbRating,
    imdbVotes,
    imdbID,
    type,
    response,
    images,
    comingSoon,
    isFavorite,
  ];
}
