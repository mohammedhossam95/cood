part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => <Object?>[];
}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {
  final bool isLoading;

  const RegisterLoadingState({required this.isLoading});
}

class RegisterSuccessState extends RegisterState {
  final RegisterResponseModel resp;

  const RegisterSuccessState({required this.resp});

  @override
  List<Object?> get props => <Object?>[resp];
}



class RegisterErrorState extends RegisterState {
  final String errorMessage;

  const RegisterErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => <Object?>[errorMessage];
}
