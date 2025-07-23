import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/features/auth/domain/usecases/upload_photo_use_case.dart';
import 'upload_photo_event.dart';
import 'upload_photo_state.dart';

class UploadPhotoBloc extends Bloc<UploadPhotoEvent, UploadPhotoState> {
  final UploadPhotoUseCase _uploadPhotoUseCase;
  final ImagePicker _imagePicker = ImagePicker();

  UploadPhotoBloc(this._uploadPhotoUseCase) : super(UploadPhotoInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<UploadPhotoActionEvent>(_onUploadPhoto);
  }

  Future<void> _onPickImage(
    PickImageEvent event,
    Emitter<UploadPhotoState> emit,
  ) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,);

      if (pickedFile != null) {
        emit(ImagePickedState(File(pickedFile.path)));
      }
    } catch (e) {
      emit(UploadPhotoError('Fotoğraf seçilemedi: ${e.toString()}'));
    }
  }

  Future<void> _onUploadPhoto(
    UploadPhotoActionEvent event,
    Emitter<UploadPhotoState> emit,
  ) async {
    emit(UploadPhotoLoading());

    final dataState = await _uploadPhotoUseCase(event.imageFile);
    print(dataState);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(UploadPhotoSuccess(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(UploadPhotoError(dataState.message.toString() ));
    }
  }
}
