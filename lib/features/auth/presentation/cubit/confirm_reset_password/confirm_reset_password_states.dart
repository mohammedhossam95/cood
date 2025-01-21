part of 'confirm_reset_password_cubit.dart';


abstract class ConfirmResetPasswordState extends Equatable {

  const ConfirmResetPasswordState();

  @override
  List<Object?> get props => <Object?>[];
}

class ConfirmResetPasswordInitialState extends ConfirmResetPasswordState {
  const ConfirmResetPasswordInitialState();
}

class ConfirmResetPasswordLoadingState extends ConfirmResetPasswordState {
  const ConfirmResetPasswordLoadingState();
}

class ConfirmResetPasswordSuccessState extends ConfirmResetPasswordState {
  const ConfirmResetPasswordSuccessState();

}

class ConfirmResetPasswordErrorState extends ConfirmResetPasswordState {
  final String message;

  const ConfirmResetPasswordErrorState({required this.message,});

  @override
  List<Object?> get props => <Object?>[message];
}

