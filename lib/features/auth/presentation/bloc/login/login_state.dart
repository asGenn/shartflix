part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  final UserEntity? user;
  final String? errorMessage;
  final String email;
  final String password;
  final bool isPasswordVisible;
  final bool isFormValid;
  final String? emailError;
  final String? passwordError;

  const LoginState({
    this.user,
    this.errorMessage,
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.isFormValid = false,
    this.emailError,
    this.passwordError,
  });

  @override
  List<Object?> get props => [
    user,
    errorMessage,
    email,
    password,
    isPasswordVisible,
    isFormValid,
    emailError,
    passwordError,
  ];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {
  const LoginLoading({
    super.email,
    super.password,
    super.isPasswordVisible,
    super.isFormValid,
    super.emailError,
    super.passwordError,
  });
}

final class LoginFormState extends LoginState {
  const LoginFormState({
    super.email,
    super.password,
    super.isPasswordVisible,
    super.isFormValid,
    super.emailError,
    super.passwordError,
  });
}

final class LoginSuccess extends LoginState {
  const LoginSuccess(UserEntity user) : super(user: user);
}

final class LoginFailure extends LoginState {
  const LoginFailure(
    String errorMessage, {
    super.email,
    super.password,
    super.isPasswordVisible,
    super.isFormValid,
    super.emailError,
    super.passwordError,
  }) : super(errorMessage: errorMessage);
}
