part of 'guest_login_cubit.dart';

abstract class GuestLoginState extends Equatable {
  const GuestLoginState();

  @override
  List<Object?> get props => <Object?>[];
}

class GuestLoginInitialState extends GuestLoginState {}

class GuestLoginLoadingState extends GuestLoginState {
  final bool isLoading;

  const GuestLoginLoadingState({required this.isLoading});
}

class GuestLoginSuccessState extends GuestLoginState {
  final LoginRespModel resp;

  const GuestLoginSuccessState({required this.resp});

  @override
  List<Object?> get props => <Object?>[resp];
}

class GuestLoginErrorState extends GuestLoginState {
  final String errorMessage;

  const GuestLoginErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => <Object?>[errorMessage];
}
