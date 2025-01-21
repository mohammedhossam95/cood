part of 'get_free_additional_cubit.dart';

sealed class GetFreeAdditionalState extends Equatable {
  const GetFreeAdditionalState();

  @override
  List<Object> get props => [];
}

final class GetFreeAdditionalInitial extends GetFreeAdditionalState {}

final class GetFreeAdditionalLoading extends GetFreeAdditionalState {
  final bool isLoading;

  const GetFreeAdditionalLoading({required this.isLoading});
}

final class GetFreeAdditionalSuccess extends GetFreeAdditionalState {
  final BaseListResponse response;

  const GetFreeAdditionalSuccess({required this.response});
}

final class GetFreeAdditionalError extends GetFreeAdditionalState {
  final String message;
  const GetFreeAdditionalError({required this.message});
}
