import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/main/presentation/bloc/profile_photo/profile_photo_bloc.dart';
import 'package:shartflix/features/main/presentation/bloc/profile_photo/profile_photo_event.dart';
import 'package:shartflix/features/main/presentation/bloc/profile_photo/profile_photo_state.dart';
import 'package:shartflix/core/shared/widgets/photo_upload_config.dart';
import 'package:shartflix/core/shared/widgets/photo_upload_widget.dart';
import 'package:shartflix/service_locator.dart';

class UploadProfilePhotoView extends StatelessWidget {
  const UploadProfilePhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfilePhotoBloc>(),
      child: BlocBuilder<ProfilePhotoBloc, ProfilePhotoState>(
        builder: (context, state) {
          return PhotoUploadWidget(
            config: PhotoUploadConfig.forAuth(),
            bloc: context.read<ProfilePhotoBloc>(),
            onPickImage: () =>
                context.read<ProfilePhotoBloc>().add(PickImageEvent()),
            onUpload: (file) => context.read<ProfilePhotoBloc>().add(
              UpdateProfilePhotoEvent(file),
            ),
            isImagePicked: state is ImagePickedState,
            isLoading: state is ProfilePhotoLoading,
            pickedImage: state is ImagePickedState ? state.imageFile : null,
            errorMessage: state is ProfilePhotoError ? state.message : null,
          );
        },
      ),
    );
  }
}
