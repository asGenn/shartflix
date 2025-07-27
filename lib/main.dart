import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/config/theme/theme.dart';
import 'package:shartflix/core/init/app_init.dart';
import 'package:shartflix/config/navigation/navigation_service.dart';
import 'package:shartflix/config/navigation/navigation_service_impl.dart';
import 'package:shartflix/config/navigation/route_generator.dart';
import 'package:shartflix/core/util/constants/navigation/navigation_constants.dart';
import 'package:shartflix/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:shartflix/features/auth/presentation/bloc/signup/signup_bloc.dart';
import 'package:shartflix/features/auth/presentation/bloc/upload_photo/upload_photo_bloc.dart';
import 'package:shartflix/features/main/presentation/bloc/home/home_bloc.dart';
import 'package:shartflix/features/splash/bloc/splash_bloc.dart';
import 'package:shartflix/service_locator.dart';

void main() async {
  await AppInit.initialize();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('tr'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = sl<NavigationService>() as NavigationServiceImpl;
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(create: (context) => sl()),
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
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        navigatorKey: navigationService.navigatorKey,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: AppRoutes.splash,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
      ),
    );
  }
}
