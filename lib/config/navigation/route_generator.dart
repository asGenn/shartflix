import 'package:flutter/material.dart';
import 'package:shartflix/core/util/constants/navigation/navigation_constants.dart';
import 'package:shartflix/features/auth/presentation/pages/login/login_view.dart';
import 'package:shartflix/features/auth/presentation/pages/signup/signup_view.dart';
import 'package:shartflix/features/auth/presentation/pages/upload_photo/upload_view.dart';
import 'package:shartflix/features/main/presentation/profile/upload_profile_photo_view.dart';
import 'package:shartflix/features/main/presentation/root_page.dart';
import 'package:shartflix/features/splash/splash_view.dart';



class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
          settings: settings,
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
          
          settings: settings,
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => const SignupView(),
          settings: settings,
        );

      case AppRoutes.uploadPhoto:
        return MaterialPageRoute(
          builder: (_) => const UploadPhotoView(),
          settings: settings,
        );

      case AppRoutes.root:
        return MaterialPageRoute(
          builder: (_) => const RootPage(),
          settings: settings,
        );

      case AppRoutes.uploadProfilePhoto:
        return MaterialPageRoute(
          builder: (_) => const UploadProfilePhotoView(),
          settings: settings,
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Sayfa bulunamadı!')),
      ),
    );
  }
}
