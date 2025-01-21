part of 'get_cities_cubit.dart';

sealed class GetCitiesState extends Equatable {
  const GetCitiesState();

  @override
  List<Object> get props => [];
}

final class GetCitiesInitial extends GetCitiesState {}

final class GetCitiesLoading extends GetCitiesState {
  final bool isLoading;

  const GetCitiesLoading({required this.isLoading});
}

final class GetCitiesSuccess extends GetCitiesState {
  final BaseListResponse response;

  const GetCitiesSuccess({required this.response});
}

final class GetCitiesError extends GetCitiesState {
  final String message;

  const GetCitiesError({required this.message});
}
