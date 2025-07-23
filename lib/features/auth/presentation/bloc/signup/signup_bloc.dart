import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shartflix/core/navigation/navigation_service.dart';
import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/core/util/constants/navigation/navigation_constants.dart';
import 'package:shartflix/features/auth/data/models/register_request_model.dart';
import 'package:shartflix/features/auth/domain/entities/user_entitiy.dart';
import 'package:shartflix/features/auth/domain/usecases/register_use_case.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final RegisterUseCase _registerUseCase;
  
  final NavigationService _navigationService;

  SignupBloc(this._registerUseCase, this._navigationService) : super(SignupInitial()) {
    on<NameChanged>(_onNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<PasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<ConfirmPasswordVisibilityToggled>(_onConfirmPasswordVisibilityToggled);
    on<SignupButtonPressed>(_onSignupButtonPressed);
    on<SocialSignupRequested>(_onSocialSignupRequested);
    on<LoginRequested>(_onLoginRequested);
  }

  void _onNameChanged(NameChanged event, Emitter<SignupState> emit) {
    final nameError = _validateName(event.name);
    final emailError = _validateEmail(state.email);
    final passwordError = _validatePassword(state.password);
    final confirmPasswordError = _validateConfirmPassword(
      state.password,
      state.confirmPassword,
    );
    final isFormValid =
        nameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmPasswordError == null;

    emit(
      SignupFormState(
        name: event.name,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        isPasswordVisible: state.isPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible,
        nameError: nameError,
        emailError: emailError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
        isFormValid: isFormValid,
      ),
    );
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignupState> emit) {
    final nameError = _validateName(state.name);
    final emailError = _validateEmail(event.email);
    final passwordError = _validatePassword(state.password);
    final confirmPasswordError = _validateConfirmPassword(
      state.password,
      state.confirmPassword,
    );
    final isFormValid =
        nameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmPasswordError == null;

    emit(
      SignupFormState(
        name: state.name,
        email: event.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        isPasswordVisible: state.isPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible,
        nameError: nameError,
        emailError: emailError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
        isFormValid: isFormValid,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignupState> emit) {
    final nameError = _validateName(state.name);
    final emailError = _validateEmail(state.email);
    final passwordError = _validatePassword(event.password);
    final confirmPasswordError = _validateConfirmPassword(
      event.password,
      state.confirmPassword,
    );
    final isFormValid =
        nameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmPasswordError == null;

    emit(
      SignupFormState(
        name: state.name,
        email: state.email,
        password: event.password,
        confirmPassword: state.confirmPassword,
        isPasswordVisible: state.isPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible,
        nameError: nameError,
        emailError: emailError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
        isFormValid: isFormValid,
      ),
    );
  }

  void _onConfirmPasswordChanged(
    ConfirmPasswordChanged event,
    Emitter<SignupState> emit,
  ) {
    final nameError = _validateName(state.name);
    final emailError = _validateEmail(state.email);
    final passwordError = _validatePassword(state.password);
    final confirmPasswordError = _validateConfirmPassword(
      state.password,
      event.confirmPassword,
    );
    final isFormValid =
        nameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmPasswordError == null;

    emit(
      SignupFormState(
        name: state.name,
        email: state.email,
        password: state.password,
        confirmPassword: event.confirmPassword,
        isPasswordVisible: state.isPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible,
        nameError: nameError,
        emailError: emailError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
        isFormValid: isFormValid,
      ),
    );
  }

  void _onPasswordVisibilityToggled(
    PasswordVisibilityToggled event,
    Emitter<SignupState> emit,
  ) {
    emit(
      SignupFormState(
        name: state.name,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        isPasswordVisible: !state.isPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible,
        nameError: state.nameError,
        emailError: state.emailError,
        passwordError: state.passwordError,
        confirmPasswordError: state.confirmPasswordError,
        isFormValid: state.isFormValid,
      ),
    );
  }

  void _onConfirmPasswordVisibilityToggled(
    ConfirmPasswordVisibilityToggled event,
    Emitter<SignupState> emit,
  ) {
    emit(
      SignupFormState(
        name: state.name,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        isPasswordVisible: state.isPasswordVisible,
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
        nameError: state.nameError,
        emailError: state.emailError,
        passwordError: state.passwordError,
        confirmPasswordError: state.confirmPasswordError,
        isFormValid: state.isFormValid,
      ),
    );
  }

  Future<void> _onSignupButtonPressed(
    SignupButtonPressed event,
    Emitter<SignupState> emit,
  ) async {
    emit(
      SignupLoading(
        name: state.name,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        isPasswordVisible: state.isPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible,
        nameError: state.nameError,
        emailError: state.emailError,
        passwordError: state.passwordError,
        confirmPasswordError: state.confirmPasswordError,
        isFormValid: state.isFormValid,
      ),
    );

    try {
      final registerRequest = RegisterRequestModel(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      final result = await _registerUseCase.call(registerRequest);

      if (result is DataSuccess) {
        emit(SignupSuccess(result.data!));
        _navigationService.navigateAndReplace(AppRoutes.uploadPhoto);
      } else {
        emit(
          SignupFailure(
            result.message ?? 'Kayıt işlemi başarısız!',
            name: state.name,
            email: state.email,
            password: state.password,
            confirmPassword: state.confirmPassword,
            isPasswordVisible: state.isPasswordVisible,
            isConfirmPasswordVisible: state.isConfirmPasswordVisible,
            nameError: state.nameError,
            emailError: state.emailError,
            passwordError: state.passwordError,
            confirmPasswordError: state.confirmPasswordError,
            isFormValid: state.isFormValid,
          ),
        );
      }
    } catch (e) {
      emit(
        SignupFailure(
          'Beklenmeyen bir hata oluştu!',
          name: state.name,
          email: state.email,
          password: state.password,
          confirmPassword: state.confirmPassword,
          isPasswordVisible: state.isPasswordVisible,
          isConfirmPasswordVisible: state.isConfirmPasswordVisible,
          nameError: state.nameError,
          emailError: state.emailError,
          passwordError: state.passwordError,
          confirmPasswordError: state.confirmPasswordError,
          isFormValid: state.isFormValid,
        ),
      );
    }
  }

  void _onSocialSignupRequested(
    SocialSignupRequested event,
    Emitter<SignupState> emit,
  ) {
    // TODO: Implement social signup
    
  }

  // Validation methods
  String? _validateName(String name) {
    if (name.isEmpty) {
      return 'Ad Soyad boş olamaz';
    }
    if (name.length < 2) {
      return 'Ad Soyad en az 2 karakter olmalı';
    }
    return null;
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'E-posta boş olamaz';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Geçerli bir e-posta adresi girin';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Şifre boş olamaz';
    }
    if (password.length < 6) {
      return 'Şifre en az 6 karakter olmalı';
    }
    return null;
  }

  String? _validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Şifre tekrarı boş olamaz';
    }
    if (password != confirmPassword) {
      return 'Şifreler eşleşmiyor';
    }
    return null;
  }

  FutureOr<void> _onLoginRequested(LoginRequested event, Emitter<SignupState> emit) {
    _navigationService.navigateAndReplace(AppRoutes.login);
  }
}
