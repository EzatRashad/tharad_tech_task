import '/features/login/model/user_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel user;
  final String message;
  LoginSuccess(this.user, this.message);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class PasswordVisibilityChanged extends LoginState {
  final bool isVisible;
  PasswordVisibilityChanged(this.isVisible);
}

class TermsAcceptedChanged extends LoginState {
  final bool isAccepted;
  TermsAcceptedChanged(this.isAccepted);
}
