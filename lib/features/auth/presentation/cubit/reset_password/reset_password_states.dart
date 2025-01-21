part of 'reset_password_cubit.dart';


abstract class ResetPasswordState extends Equatable {

  const ResetPasswordState();

  @override
  List<Object?> get props => <Object?>[];
}

class ResetPasswordInitialState extends ResetPasswordState {
  const ResetPasswordInitialState();
}

class ResetPasswordLoadingState extends ResetPasswordState {
  const ResetPasswordLoadingState();
}

class ResetPasswordSuccessState extends ResetPasswordState {
  const ResetPasswordSuccessState();

}

class ResetPasswordErrorState extends ResetPasswordState {
  final String message;

  const ResetPasswordErrorState({required this.message,});

  @override
  List<Object?> get props => <Object?>[message];
}

