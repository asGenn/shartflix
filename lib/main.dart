import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/config/theme/theme.dart';
import 'package:shartflix/core/navigation/navigation_service.dart';
import 'package:shartflix/core/navigation/navigation_service_impl.dart';
import 'package:shartflix/core/navigation/route_generator.dart';
import 'package:shartflix/core/util/constants/navigation/navigation_constants.dart';
import 'package:shartflix/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:shartflix/features/auth/presentation/bloc/signup/signup_bloc.dart';
import 'package:shartflix/features/auth/presentation/bloc/upload_photo/upload_photo_bloc.dart';
import 'package:shartflix/features/main/presentation/bloc/home/home_bloc.dart';
import 'package:shartflix/service_locator.dart';

void main() {
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final navigationService = sl<NavigationService>() as NavigationServiceImpl;
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => sl()),
        BlocProvider<SignupBloc>(create: (context) => sl()),
        BlocProvider<UploadPhotoBloc>(create: (context) => sl()),
        BlocProvider<HomeBloc>(create: (context) => sl()),
      ],
      child: MaterialApp(
        title: 'Shartflix',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: ThemeMode.system,

        navigatorKey: navigationService.navigatorKey,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: AppRoutes.login,
      ),
    );
  }
}
