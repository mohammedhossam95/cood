part of 'get_user_cubit.dart';

sealed class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

final class GetUserInitial extends GetUserState {}

final class GetUserLoading extends GetUserState {
  final bool isLoading;

  const GetUserLoading({required this.isLoading});
}

final class GetUserSuccess extends GetUserState {
  final BaseOneResponse response;

  const GetUserSuccess({required this.response});
}

final class GetUserError extends GetUserState {
  final String message;

  const GetUserError({required this.message});
}
