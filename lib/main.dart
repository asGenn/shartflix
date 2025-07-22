import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/config/theme/theme.dart';
import 'package:shartflix/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:shartflix/features/auth/presentation/pages/login/login_view.dart';
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
    return BlocProvider<LoginBloc>(
      create: (context) => sl(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: ThemeMode.system,
        home: const LoginView(),
      ),
    );
  }
}
