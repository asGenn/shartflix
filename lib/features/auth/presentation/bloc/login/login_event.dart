part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  const LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class EmailChanged extends LoginEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class PasswordVisibilityToggled extends LoginEvent {}

class FormValidationRequested extends LoginEvent {}

class SocialLoginRequested extends LoginEvent {
  final String provider; // 'google', 'apple', 'facebook'
  const SocialLoginRequested(this.provider);

  @override
  List<Object> get props => [provider];
}
