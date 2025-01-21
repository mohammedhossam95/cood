part of 'get_additional_cubit.dart';

sealed class GetAdditionalState extends Equatable {
  const GetAdditionalState();

  @override
  List<Object> get props => [];
}

final class GetAdditionalInitial extends GetAdditionalState {}

final class GetAdditionalLoading extends GetAdditionalState {
  final bool isLoading;

  const GetAdditionalLoading({required this.isLoading});
}

final class GetAdditionalSuccess extends GetAdditionalState {
  final BaseListResponse response;

  const GetAdditionalSuccess({required this.response});
}

final class GetAdditionalError extends GetAdditionalState {
  final String message;
  const GetAdditionalError({required this.message});
}
