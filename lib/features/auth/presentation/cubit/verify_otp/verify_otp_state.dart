part of 'verify_otp_cubit.dart';

abstract class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object?> get props => <Object?>[];
}

class VerifyOtpInitialState extends VerifyOtpState {}

class VerifyOtpLoading extends VerifyOtpState {
  final bool isLoading;
  const VerifyOtpLoading({required this.isLoading});
}

class VerifyOtpSuccess extends VerifyOtpState {
  final BaseOneResponse resp;

  const VerifyOtpSuccess({required this.resp});

  @override
  List<Object?> get props => <Object?>[resp];
}

class VerifyOtpError extends VerifyOtpState {
  final String errorMessage;

  const VerifyOtpError({required this.errorMessage});

  @override
  List<Object?> get props => <Object?>[errorMessage];
}
