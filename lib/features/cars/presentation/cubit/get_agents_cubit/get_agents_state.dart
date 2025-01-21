part of 'get_agents_cubit.dart';

sealed class GetAgentsState extends Equatable {
  const GetAgentsState();

  @override
  List<Object> get props => [];
}

final class GetAgentsInitial extends GetAgentsState {}

final class GetAgentsLoading extends GetAgentsState {
  final bool isLoading;

  const GetAgentsLoading({required this.isLoading});
}

final class GetAgentsSuccess extends GetAgentsState {
  final BaseListResponse response;

  const GetAgentsSuccess({required this.response});
}

final class GetAgentsError extends GetAgentsState {
  final String message;

  const GetAgentsError({required this.message});
}
