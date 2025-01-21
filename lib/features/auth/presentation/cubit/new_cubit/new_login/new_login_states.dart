part of 'new_login_cubit.dart';

abstract class NewLoginState extends Equatable {
  const NewLoginState();

  @override
  List<Object?> get props => <Object?>[];
}

class LoginInitialState extends NewLoginState {}

class NewLoginLoadingState extends NewLoginState {
  final bool isLoading;

  const NewLoginLoadingState({required this.isLoading});
}

class NewLoginSuccessState extends NewLoginState {
  final LoginResponseModel resp;

  const NewLoginSuccessState({required this.resp});

  @override
  List<Object?> get props => <Object?>[resp];
}



class NewLoginErrorState extends NewLoginState {
  final String errorMessage;

  const NewLoginErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => <Object?>[errorMessage];
}
