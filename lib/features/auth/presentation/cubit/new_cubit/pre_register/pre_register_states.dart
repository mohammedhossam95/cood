part of 'pre_register_cubit.dart';



abstract class PreRegisterState extends Equatable {
  const PreRegisterState();

  @override
  List<Object?> get props => <Object?>[];
}

class PreRegisterInitialState extends PreRegisterState {}

class PreRegisterLoadingState extends PreRegisterState {
  final bool isLoading;

  const PreRegisterLoadingState({required this.isLoading});
}

class PreRegisterSuccessState extends PreRegisterState {
  final PreRegisterResponseModel resp;

  const PreRegisterSuccessState({required this.resp});

  @override
  List<Object?> get props => <Object?>[resp];
}



class PreRegisterErrorState extends PreRegisterState {
  final String errorMessage;

  const PreRegisterErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => <Object?>[errorMessage];
}
