import 'package:flutter/material.dart';
import 'package:shartflix/core/util/constants/navigation/navigation_constants.dart';
import 'package:shartflix/features/auth/presentation/pages/login/login_view.dart';



class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
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
