part of 'get_categories_cubit.dart';

sealed class GetCategoriesState extends Equatable {
  const GetCategoriesState();

  @override
  List<Object> get props => [];
}

final class GetCategoriesInitial extends GetCategoriesState {}
final class GetCategoriesLoading extends GetCategoriesState {
  final bool isLoading;
  const GetCategoriesLoading({required this.isLoading});
}
final class GetCategoriesSuccess extends GetCategoriesState {
  final BaseListResponse response;
  const GetCategoriesSuccess({required this.response});
}
final class GetCategoriesError extends GetCategoriesState {
  final String message;
  const GetCategoriesError({required this.message});
}
