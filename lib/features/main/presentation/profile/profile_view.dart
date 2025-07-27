import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/main/domain/entities/movie_entity.dart';
import 'package:shartflix/features/main/presentation/bloc/profile_photo/profile_photo_bloc.dart';
import 'package:shartflix/features/main/presentation/bloc/profile_photo/profile_photo_event.dart';
import 'package:shartflix/features/main/presentation/bloc/profile_photo/profile_photo_state.dart';

import '../../../../core/util/helpers/image_helper.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';
import '../widgets/premium_offer_modal.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.surface,

              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.2),
              ),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () {},
        ),
        title: Text(
          'profile.title'.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              onPressed: () {
                PremiumOfferModal.show(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.favorite, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'profile.limited_offer'.tr(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ProfileBloc>().add(const LoadFavoriteMoviesEvent());
              context.read<ProfileBloc>().add(const LoadProfileEvent());
            },
            color: Colors.red,
            backgroundColor: Colors.black,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Profile Section
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[700],
                        backgroundImage:
                            (state is ProfileLoaded &&
                                state.user?.photoUrl != null)
                            ? NetworkImage(state.user!.photoUrl!)
                            : null,
                        child:
                            (state is ProfileLoaded &&
                                state.user?.photoUrl != null)
                            ? null
                            : const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state is ProfileLoaded && state.user != null
                                  ? state.user!.name
                                  : 'profile.user'.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              state is ProfileLoaded && state.user != null
                                  ? 'ID: ${state.user!.id}'
                                  : 'ID: ...',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<ProfilePhotoBloc, ProfilePhotoState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              context.read<ProfilePhotoBloc>().add(
                                UploadProfileButtonPressedEvent(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                            child: Text(
                              'profile.add_photo'.tr(),
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Favorite Movies Section
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'profile.favorite_movies'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Movies Grid
                  if (state is ProfileLoaded)
                    state.isFavoriteMoviesLoading
                        ? const Center(
                            child: CircularProgressIndicator(color: Colors.red),
                          )
                        : state.favoriteMovies?.isEmpty ?? true
                        ? Center(
                            child: Text(
                              'profile.no_favorites'.tr(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                            itemCount: state.favoriteMovies?.length ?? 0,
                            itemBuilder: (context, index) {
                              final movie = state.favoriteMovies![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: _buildFavoriteMovieCard(movie),
                              );
                            },
                          )
                  else if (state is ProfileError)
                    Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  else
                    const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFavoriteMovieCard(MovieEntity movie) {
    final posterUrl = ImageHelper.convertToHttps(movie.poster);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              posterUrl ?? '',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          movie.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),

        Text(
          movie.director,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}
