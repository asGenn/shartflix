import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/core/shared/widgets/app_snackbar.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/custom_button.dart';
import 'package:shartflix/core/shared/widgets/photo_upload_config.dart';

class PhotoUploadWidget extends StatelessWidget {
  final PhotoUploadConfig config;
  final BlocBase bloc;
  final Function() onPickImage;
  final Function(File) onUpload;
  final bool isImagePicked;
  final bool isLoading;
  final File? pickedImage;
  final String? errorMessage;

  const PhotoUploadWidget({
    super.key,
    required this.config,
    required this.bloc,
    required this.onPickImage,
    required this.onUpload,
    required this.isImagePicked,
    required this.isLoading,
    this.pickedImage,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: config.showBackButton
          ? AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: config.onBackPressed ?? () => Navigator.pop(context),
              ),
              centerTitle: true,
              title: const Text(
                'Profil Detayı',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : null,
      body: BlocListener(
        bloc: bloc,
        listener: (context, state) {
          if (state.toString().contains('Success')) {
            AppSnackbar.show(
              context: context,
              message: 'Profil fotoğrafı başarıyla yüklendi',
              type: SnackBarType.success,
            );
          } else if (state.toString().contains('Error')) {
            AppSnackbar.show(
              context: context,
              message: errorMessage ?? 'Bir hata oluştu',
              type: SnackBarType.error,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                config.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                config.subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 60),
              GestureDetector(
                onTap: onPickImage,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade800),
                  ),
                  child: isImagePicked && pickedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(pickedImage!, fit: BoxFit.cover),
                        )
                      : const Icon(Icons.add, color: Colors.grey, size: 48),
                ),
              ),
              const Spacer(),
              CustomButton(
                text: isLoading ? 'Yükleniyor...' : config.buttonText,
                onPressed: isImagePicked && !isLoading && pickedImage != null
                    ? () => onUpload(pickedImage!)
                    : null,
                isLoading: isLoading,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
