abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final String message;
  OtpSuccess({required this.message});
}

class OtpError extends OtpState {
  final String message;
  OtpError({required this.message});
}

class OtpCodeChanged extends OtpState {
  final List<String> code;
  OtpCodeChanged({required this.code});
}
