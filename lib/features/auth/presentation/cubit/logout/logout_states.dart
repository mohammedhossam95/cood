part of 'logout_cubit.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object?> get props => <Object?>[];
}

class LogoutInitialState extends LogoutState {
  const LogoutInitialState();
}

class LogoutLoadingState extends LogoutState {
  final bool isLoading;
  const LogoutLoadingState({required this.isLoading});
}

class LogoutSuccessState extends LogoutState {
  final BaseOneResponse resp;
  const LogoutSuccessState({required this.resp});
}

class LogoutErrorState extends LogoutState {
  final String errorMessage;

  const LogoutErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => <Object?>[errorMessage];
}
