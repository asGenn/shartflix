import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../domain/repository/main_user_repository.dart';
import '../../../domain/usecases/get_favorite_movies_use_case.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetFavoriteMoviesUseCase _getFavoriteMoviesUseCase;
  final MainUserRepository _userRepository;

  ProfileBloc({
    required GetFavoriteMoviesUseCase getFavoriteMoviesUseCase,
    required MainUserRepository userRepository,
  }) : _getFavoriteMoviesUseCase = getFavoriteMoviesUseCase,
       _userRepository = userRepository,
       super(const ProfileInitial()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<LoadFavoriteMoviesEvent>(_onLoadFavoriteMovies);
  }

  void _onLoadProfile(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    try {
      final userDataState = await _userRepository.getCurrentUser();

      if (userDataState is DataSuccess) {
        emit(
          ProfileLoaded(
            user: userDataState.data,
            favoriteMovies: null,
            isFavoriteMoviesLoading: false,
          ),
        );
  
        add(const LoadFavoriteMoviesEvent());
      } else if (userDataState is DataFailed) {
        emit(ProfileError(userDataState.message ?? 'User bilgileri alınamadı'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void _onLoadFavoriteMovies(
    LoadFavoriteMoviesEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      emit(currentState.copyWith(isFavoriteMoviesLoading: true));
    } else {
      emit(const ProfileLoaded(isFavoriteMoviesLoading: true));
    }

    try {
      final dataState = await _getFavoriteMoviesUseCase(const NoParams());

      if (dataState is DataSuccess) {
        if (state is ProfileLoaded) {
          final currentState = state as ProfileLoaded;
          emit(
            currentState.copyWith(
              favoriteMovies: dataState.data,
              isFavoriteMoviesLoading: false,
            ),
          );
        } else {
          emit(
            ProfileLoaded(
              favoriteMovies: dataState.data,
              isFavoriteMoviesLoading: false,
            ),
          );
        }
      } else if (dataState is DataFailed) {
        emit(ProfileError(dataState.message ?? 'Bilinmeyen hata'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
