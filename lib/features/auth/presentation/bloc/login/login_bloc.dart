import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/features/auth/data/models/login_request_model.dart';
import 'package:shartflix/features/auth/domain/entities/user_entitiy.dart';
import 'package:shartflix/features/auth/domain/usecases/login_use_case.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(LoginInitial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<FormValidationRequested>(_onFormValidationRequested);
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<SocialLoginRequested>(_onSocialLoginRequested);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final emailError = _validateEmail(event.email);
    final passwordError = _validatePassword(state.password);
    final isFormValid = emailError == null && passwordError == null;

    emit(
      LoginFormState(
        email: event.email,
        password: state.password,
        isPasswordVisible: state.isPasswordVisible,
        emailError: emailError,
        passwordError: passwordError,
        isFormValid: isFormValid,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final emailError = _validateEmail(state.email);
    final passwordError = _validatePassword(event.password);
    final isFormValid = emailError == null && passwordError == null;

    emit(
      LoginFormState(
        email: state.email,
        password: event.password,
        isPasswordVisible: state.isPasswordVisible,
        emailError: emailError,
        passwordError: passwordError,
        isFormValid: isFormValid,
      ),
    );
  }

  void _onPasswordVisibilityToggled(
    PasswordVisibilityToggled event,
    Emitter<LoginState> emit,
  ) {
    emit(
      LoginFormState(
        email: state.email,
        password: state.password,
        isPasswordVisible: !state.isPasswordVisible,
        isFormValid: state.isFormValid,
        emailError: state.emailError,
        passwordError: state.passwordError,
      ),
    );
  }

  void _onFormValidationRequested(
    FormValidationRequested event,
    Emitter<LoginState> emit,
  ) {
    final emailError = _validateEmail(state.email);
    final passwordError = _validatePassword(state.password);
    final isFormValid = emailError == null && passwordError == null;

    emit(
      LoginFormState(
        email: state.email,
        password: state.password,
        isPasswordVisible: state.isPasswordVisible,
        emailError: emailError,
        passwordError: passwordError,
        isFormValid: isFormValid,
      ),
    );
  }

 
 Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      LoginLoading(
        email: state.email,
        password: state.password,
        isPasswordVisible: state.isPasswordVisible,
        isFormValid: state.isFormValid,
        emailError: state.emailError,
        passwordError: state.passwordError,
      ),
    );

    final result = await _loginUseCase(
      LoginRequestModel(email: event.email, password: event.password),
    );

    if (result is DataSuccess && result.data != null) {
      emit(LoginSuccess(result.data!));
    } else if (result is DataFailed) {
      emit(
        LoginFailure(
          result.message!,
          email: state.email,
          password: state.password,
          isPasswordVisible: state.isPasswordVisible,
          isFormValid: state.isFormValid,
          emailError: state.emailError,
          passwordError: state.passwordError,
        ),
      );
    }
  }

  Future<void> _onSocialLoginRequested(
    SocialLoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      LoginLoading(
        email: state.email,
        password: state.password,
        isPasswordVisible: state.isPasswordVisible,
        isFormValid: state.isFormValid,
      ),
    );

    // TODO: Implement social login logic
    // For now, just simulate a delay
    await Future.delayed(const Duration(seconds: 2));

    emit(
      LoginFailure(
        '${event.provider} ile giriş henüz mevcut değil',
        email: state.email,
        password: state.password,
        isPasswordVisible: state.isPasswordVisible,
        isFormValid: state.isFormValid,
      ),
    );
  }

  // Validation methods
  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email adresi gerekli';
    }
    if (!email.contains('@')) {
      return 'Geçerli bir email adresi girin';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Şifre gerekli';
    }
    if (password.length < 6) {
      return 'Şifre en az 6 karakter olmalı';
    }
    return null;
  }
}
