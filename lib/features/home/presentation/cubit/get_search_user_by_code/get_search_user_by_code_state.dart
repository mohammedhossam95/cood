

import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:equatable/equatable.dart';

sealed class GetSearchUserByCodeState extends Equatable {
  const GetSearchUserByCodeState();

  @override
  List<Object> get props => [];
}

final class GetSearchUserByCodeInitial extends GetSearchUserByCodeState {}

final class GetSearchUserByCodeLoading extends GetSearchUserByCodeState {
  final bool isLoading;

  const GetSearchUserByCodeLoading({required this.isLoading});
}

final class GetSearchUserByCodeSuccess extends GetSearchUserByCodeState {
  final BaseOneResponse response;

  const GetSearchUserByCodeSuccess({required this.response});
}

final class GetSearchUserByCodeFailure extends GetSearchUserByCodeState {
  final String errorMessage;

  const GetSearchUserByCodeFailure({required this.errorMessage});
}
