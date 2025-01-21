part of 'user_register_cubit.dart';

sealed class UserRegisterState extends Equatable {
  const UserRegisterState();

  @override
  List<Object> get props => [];
}

final class UserRegisterInitial extends UserRegisterState {}

final class UserRegisterLoading extends UserRegisterState {
  final bool isLoading;

  const UserRegisterLoading({required this.isLoading});
}

final class UserRegisterSuccess extends UserRegisterState {
  final UserRegisterRespModel resp;

  const UserRegisterSuccess({required this.resp});
}

final class UserRegisterFailure extends UserRegisterState {
  final String errorMessage;

  const UserRegisterFailure({required this.errorMessage});
}
