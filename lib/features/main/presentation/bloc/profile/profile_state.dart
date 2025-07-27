import 'package:equatable/equatable.dart';

import '../../../../../core/shared/entities/user_entity.dart';
import '../../../domain/entities/movie_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final UserEntity? user;
  final List<MovieEntity>? favoriteMovies;
  final bool isFavoriteMoviesLoading;

  const ProfileLoaded({
    this.user,
    this.favoriteMovies,
    this.isFavoriteMoviesLoading = false,
  });

  ProfileLoaded copyWith({
    UserEntity? user,
    List<MovieEntity>? favoriteMovies,
    bool? isFavoriteMoviesLoading,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
      isFavoriteMoviesLoading:
          isFavoriteMoviesLoading ?? this.isFavoriteMoviesLoading,
    );
  }

  @override
  List<Object?> get props => [user, favoriteMovies, isFavoriteMoviesLoading];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}
