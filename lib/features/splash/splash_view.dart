import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shartflix/service_locator.dart';

import 'bloc/splash_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SplashBloc>(),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashCompleted) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Image(
                image: AssetImage('assets/images/SinFlixSplash-BG.png'),
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
              Center(
                child: Lottie.asset(
                  'assets/anim/sinFlixLogo_anim.json',
                  onLoaded: (composition) {
                    Future.delayed(
                      Duration(
                        milliseconds: composition.duration.inMilliseconds,
                      ),
                      () {
                        if (!context.mounted) {
                          return;
                        }
                        context.read<SplashBloc>().add(
                          SplashAnimationCompleted(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
