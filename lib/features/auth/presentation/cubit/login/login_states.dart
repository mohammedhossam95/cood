part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => <Object?>[];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {
  final bool isLoading;

  const LoginLoadingState({required this.isLoading});
}

class LoginSuccessState extends LoginState {
  final LoginRespModel resp;

  const LoginSuccessState({required this.resp});

  @override
  List<Object?> get props => <Object?>[resp];
}

class LoginErrorState extends LoginState {
  final String errorMessage;

  const LoginErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => <Object?>[errorMessage];
}
