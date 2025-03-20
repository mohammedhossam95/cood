
import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:equatable/equatable.dart';

sealed class GetFilterUserByCategoryState extends Equatable {
  const GetFilterUserByCategoryState();

  @override
  List<Object> get props => [];
}

final class GetFilterUserByCategoryInitial extends GetFilterUserByCategoryState {}

final class GetFilterUserByCategoryLoading extends GetFilterUserByCategoryState {
  final bool isLoading;

  const GetFilterUserByCategoryLoading({required this.isLoading});
}

final class GetFilterUserByCategorySuccerss extends GetFilterUserByCategoryState {
  final BaseOneResponse response;

  const GetFilterUserByCategorySuccerss({required this.response});
}

final class GetFilterUserByCategoryFailure extends GetFilterUserByCategoryState {
  final String errorMessage;

  const GetFilterUserByCategoryFailure({required this.errorMessage});
}

