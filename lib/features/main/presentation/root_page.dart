import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/core/shared/widgets/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:shartflix/core/shared/widgets/bottom_navigation/custom_bottom_navigation.dart';
import 'package:shartflix/features/main/presentation/bloc/home/home_bloc.dart';
import 'package:shartflix/features/main/presentation/bloc/profile/profile_bloc.dart';
import 'package:shartflix/features/main/presentation/bloc/profile/profile_event.dart';
import 'package:shartflix/features/main/presentation/bloc/profile_photo/profile_photo_bloc.dart';
import 'package:shartflix/features/main/presentation/home/home_view.dart';
import 'package:shartflix/features/main/presentation/profile/profile_view.dart';
import 'package:shartflix/service_locator.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  static final List<Widget> _pages = [const HomeView(), const ProfileView()];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          SystemNavigator.pop();
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: sl<BottomNavigationBloc>()),
          BlocProvider.value(value: sl<HomeBloc>()),
          BlocProvider.value(
            value: sl<ProfileBloc>()
              ..add(LoadFavoriteMoviesEvent())
              ..add(LoadProfileEvent()),
          ),
          BlocProvider.value(value: sl<ProfilePhotoBloc>()),
        ],
        child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
          builder: (context, state) {
            return Scaffold(
              body: IndexedStack(index: state.currentIndex, children: _pages),
              bottomNavigationBar: CustomBottomNavigation(
                items: const [
                  NavigationItem(
                    icon: Icons.home_outlined,
                    filledIcon: Icons.home_filled,
                    label: 'Ana Sayfa',
                  ),
                  NavigationItem(
                    icon: Icons.person_outline,
                    filledIcon: Icons.person,
                    label: 'Profil',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
