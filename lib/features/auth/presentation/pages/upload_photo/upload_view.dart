import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/core/widgets/app_snackbar.dart';
import 'package:shartflix/features/auth/presentation/bloc/upload_photo/upload_photo_bloc.dart';
import 'package:shartflix/features/auth/presentation/bloc/upload_photo/upload_photo_event.dart';
import 'package:shartflix/features/auth/presentation/bloc/upload_photo/upload_photo_state.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/custom_button.dart';

class UploadPhotoView extends StatelessWidget {
  const UploadPhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Profil Detayı',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: BlocConsumer<UploadPhotoBloc, UploadPhotoState>(
        listener: (context, state) {
          if (state is UploadPhotoSuccess) {
            AppSnackbar.show(
              context: context,
              message: 'Profil fotoğrafı başarıyla yüklendi',
              type: SnackBarType.success,
            );
            Navigator.pop(context);
          } else if (state is UploadPhotoError) {
            AppSnackbar.show(
              context: context,
              message: state.message,
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Fotoğraflarınızı Yükleyin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Resources out incentivize\nrelaxation floor loss cc.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 60),
                GestureDetector(
                  onTap: () =>
                      context.read<UploadPhotoBloc>().add(PickImageEvent()),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    child: state is ImagePickedState
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              state.imageFile,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.add, color: Colors.grey, size: 48),
                  ),
                ),
                const Spacer(),
                CustomButton(
                  text: state is UploadPhotoLoading
                      ? 'Yükleniyor...'
                      : 'Devam Et',
                  onPressed:
                      state is ImagePickedState && state is! UploadPhotoLoading
                      ? () => context.read<UploadPhotoBloc>().add(
                          UploadPhotoActionEvent(state.imageFile),
                        )
                      : () {},
                  isLoading: state is UploadPhotoLoading,
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
