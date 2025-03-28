

import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:equatable/equatable.dart';

sealed class PostSelectedCategoryState extends Equatable {
  const PostSelectedCategoryState();

  @override
  List<Object> get props => [];
}

final class PostSelectedCategoryInitial extends PostSelectedCategoryState {}

final class PostSelectedCategoryLoading extends PostSelectedCategoryState {
  final bool isLoading;

  const PostSelectedCategoryLoading({required this.isLoading});
}

final class PostSelectedCategorySuccerss extends PostSelectedCategoryState {
  final BaseListResponse response;

  const PostSelectedCategorySuccerss({required this.response});
}

final class PostSelectedCategoryFailure extends PostSelectedCategoryState {
  final String errorMessage;

  const PostSelectedCategoryFailure({required this.errorMessage});
}
