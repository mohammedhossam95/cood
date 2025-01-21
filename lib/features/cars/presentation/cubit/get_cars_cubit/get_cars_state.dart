part of 'get_cars_cubit.dart';

sealed class GetCarsState extends Equatable {
  const GetCarsState();

  @override
  List<Object> get props => [];
}

final class GetCarsInitial extends GetCarsState {}

final class GetCarsLoading extends GetCarsState {
  final bool isLoading;

  const GetCarsLoading({required this.isLoading});
}

final class GetCarsSuccess extends GetCarsState {
  final BaseListResponse response;

  const GetCarsSuccess({required this.response});
}

final class GetCarsError extends GetCarsState {
  final String message;

  const GetCarsError({required this.message});
}
