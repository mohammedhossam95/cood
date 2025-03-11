part of 'categories_cubit.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {
  final bool isLoading;

  const CategoriesLoading({required this.isLoading});
}

final class CategoriesSuccerss extends CategoriesState {
  final BaseListResponse response;

  const CategoriesSuccerss({required this.response});
}

final class CategoriesFailure extends CategoriesState {
  final String errorMessage;

  const CategoriesFailure({required this.errorMessage});
}
