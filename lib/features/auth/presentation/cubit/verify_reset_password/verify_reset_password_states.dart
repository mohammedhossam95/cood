part of 'verify_reset_password_cubit.dart';


abstract class VerifyResetPasswordState extends Equatable {

  const VerifyResetPasswordState();

  @override
  List<Object?> get props => <Object?>[];
}

class VerifyResetPasswordInitialState extends VerifyResetPasswordState {
  const VerifyResetPasswordInitialState();
}

class VerifyResetPasswordLoadingState extends VerifyResetPasswordState {
  const VerifyResetPasswordLoadingState();
}

class VerifyResetPasswordSuccessState extends VerifyResetPasswordState {
  const VerifyResetPasswordSuccessState();

}

class VerifyResetPasswordErrorState extends VerifyResetPasswordState {
  final String message;

  const VerifyResetPasswordErrorState({required this.message,});

  @override
  List<Object?> get props => <Object?>[message];
}

