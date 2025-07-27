import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shartflix/config/navigation/navigation_service.dart';
import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/core/util/constants/navigation/navigation_constants.dart';
import 'package:shartflix/features/main/domain/usecases/update_profile_photo_use_case.dart';
import 'package:shartflix/features/main/presentation/bloc/profile_photo/profile_photo_event.dart';
import 'package:shartflix/features/main/presentation/bloc/profile_photo/profile_photo_state.dart';

class ProfilePhotoBloc extends Bloc<ProfilePhotoEvent, ProfilePhotoState> {
  final UpdateProfilePhotoUseCase _updateProfilePhotoUseCase;
  final NavigationService _navigationService;
  final ImagePicker _imagePicker = ImagePicker();

  ProfilePhotoBloc(this._updateProfilePhotoUseCase, this._navigationService)
    : super(ProfilePhotoInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<UpdateProfilePhotoEvent>(_onUpdateProfilePhoto);
    on<UploadProfileButtonPressedEvent>(_onUploadProfileButtonPressed);
  }

  Future<void> _onPickImage(
    PickImageEvent event,
    Emitter<ProfilePhotoState> emit,
  ) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        emit(ImagePickedState(File(image.path)));
      }
    } catch (e) {
      emit(ProfilePhotoError('Fotoğraf seçilirken hata oluştu: $e'));
    }
  }

  Future<void> _onUpdateProfilePhoto(
    UpdateProfilePhotoEvent event,
    Emitter<ProfilePhotoState> emit,
  ) async {
    emit(ProfilePhotoLoading());

    try {
      final result = await _updateProfilePhotoUseCase(event.imageFile);

      if (result is DataSuccess) {
        emit(ProfilePhotoSuccess());
        _navigationService.goBack();
      } else if (result is DataFailed) {
        emit(ProfilePhotoError(result.message ?? 'Bilinmeyen hata'));
      }
    } catch (e) {
      emit(ProfilePhotoError('Fotoğraf yüklenirken hata oluştu: $e'));
    }
  }

  FutureOr<void> _onUploadProfileButtonPressed(
    UploadProfileButtonPressedEvent event,
    Emitter<ProfilePhotoState> emit,
  ) {
    _navigationService.navigateTo(AppRoutes.uploadProfilePhoto);
  }
}
