part of 'verify_otp_cubit.dart';

abstract class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object?> get props => <Object?>[];
}

class VerifyOtpInitialState extends VerifyOtpState {}

class VerifyOtpLoadingState extends VerifyOtpState {
  final bool isLoading;
  const VerifyOtpLoadingState({required this.isLoading});
}

class VerifyOtpSuccessState extends VerifyOtpState {
  final ConfirmCodeAuthRespModel resp;

  const VerifyOtpSuccessState({required this.resp});

  @override
  List<Object?> get props => <Object?>[resp];
}

class VerifyOtpErrorState extends VerifyOtpState {
  final String errorMessage;

  const VerifyOtpErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => <Object?>[errorMessage];
}
