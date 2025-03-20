import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:equatable/equatable.dart';

sealed class GetUserGallaryState extends Equatable {
  const GetUserGallaryState();

  @override
  List<Object> get props => [];
}

final class GetUserGallaryInitial extends GetUserGallaryState {}

final class GetUserGallaryLoading extends GetUserGallaryState {
  final bool isLoading;

  const GetUserGallaryLoading({required this.isLoading});
}

final class GetUserGallarySuccerss extends GetUserGallaryState {
  final BaseListResponse response;

  const GetUserGallarySuccerss({required this.response});
}

final class GetUserGallaryFailure extends GetUserGallaryState {
  final String errorMessage;

  const GetUserGallaryFailure({required this.errorMessage});
}
