import 'package:tharad_tech/features/profile/model/profile_details_model.dart';

abstract class ProfileState {}

class GetProfileInitialState extends ProfileState {}

class GetProfileLoading extends ProfileState {}

class GetProfileSuccess extends ProfileState {
  final ProfileDetailsModel model;
  final String? message;
  GetProfileSuccess(this.model, {this.message});
}

class GetProfileError extends ProfileState {
  final String error;
  GetProfileError(this.error);
}

class UpdateProfileLoading extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {
  final String message;
  UpdateProfileSuccess(this.message);
}

class UpdateProfileError extends ProfileState {
  final String error;
  UpdateProfileError(this.error);
}

class PasswordVisibilityChanged extends ProfileState {
  final bool isVisible;
  PasswordVisibilityChanged(this.isVisible);
}

class RegisterImagePicked extends ProfileState {}

class SelectNewImage extends ProfileState {
  SelectNewImage(this.select);

  final bool select;
}
