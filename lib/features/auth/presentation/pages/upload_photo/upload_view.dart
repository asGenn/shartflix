import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/auth/presentation/bloc/upload_photo/upload_photo_bloc.dart';
import 'package:shartflix/features/auth/presentation/bloc/upload_photo/upload_photo_event.dart';
import 'package:shartflix/features/auth/presentation/bloc/upload_photo/upload_photo_state.dart';
import 'package:shartflix/core/shared/widgets/photo_upload_config.dart';
import 'package:shartflix/core/shared/widgets/photo_upload_widget.dart';

class UploadPhotoView extends StatelessWidget {
  const UploadPhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPhotoBloc, UploadPhotoState>(
      builder: (context, state) {
        return PhotoUploadWidget(
          config: PhotoUploadConfig.forAuth(),
          bloc: context.read<UploadPhotoBloc>(),
          onPickImage: () =>
              context.read<UploadPhotoBloc>().add(PickImageEvent()),
          onUpload: (file) =>
              context.read<UploadPhotoBloc>().add(UploadPhotoActionEvent(file)),
          isImagePicked: state is ImagePickedState,
          isLoading: state is UploadPhotoLoading,
          pickedImage: state is ImagePickedState ? state.imageFile : null,
          errorMessage: state is UploadPhotoError ? state.message : null,
        );
      },
    );
  }
}
