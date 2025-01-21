part of 'get_plans_status_cubit.dart';

sealed class GetPlansStatusState extends Equatable {
  const GetPlansStatusState();

  @override
  List<Object> get props => [];
}

final class GetPlansStatusInitial extends GetPlansStatusState {}

final class GetPlansStatusLoading extends GetPlansStatusState {
  final bool isLoading;

  const GetPlansStatusLoading({required this.isLoading});
}

final class GetPlansStatusSuccess extends GetPlansStatusState {
  final BaseOneResponse response;

  const GetPlansStatusSuccess({required this.response});
}

final class GetPlansStatusError extends GetPlansStatusState {
  final String message;

  const GetPlansStatusError({required this.message});
}
