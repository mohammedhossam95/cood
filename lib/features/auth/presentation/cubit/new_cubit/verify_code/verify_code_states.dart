part of 'verify_code_cubit.dart';

abstract class VerifyCodeState extends Equatable {
  const VerifyCodeState();

  @override
  List<Object?> get props => <Object?>[];
}

class VerifyCodeInitialState extends VerifyCodeState {}

class VerifyCodeLoadingState extends VerifyCodeState {
  final bool isLoading;

  const VerifyCodeLoadingState({required this.isLoading});
}

class VerifyCodeSuccessState extends VerifyCodeState {
  final VerifyCodeResponseModel resp;

  const VerifyCodeSuccessState({required this.resp});

  @override
  List<Object?> get props => <Object?>[resp];
}



class VerifyCodeErrorState extends VerifyCodeState {
  final String errorMessage;

  const VerifyCodeErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => <Object?>[errorMessage];
}
