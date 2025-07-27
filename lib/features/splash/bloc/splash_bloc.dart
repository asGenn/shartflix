import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/config/navigation/navigation_service.dart';
import 'package:shartflix/core/util/constants/navigation/navigation_constants.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final NavigationService _navigationService;
  SplashBloc(this._navigationService) : super(SplashInitial()) {
    on<SplashAnimationCompleted>(_onSplashAnimationCompleted);
  }

  void _onSplashAnimationCompleted(
    SplashAnimationCompleted event,
    Emitter<SplashState> emit,
  ) {
    emit(SplashCompleted());
    _navigationService.navigateAndReplace(AppRoutes.login);
  }
}
