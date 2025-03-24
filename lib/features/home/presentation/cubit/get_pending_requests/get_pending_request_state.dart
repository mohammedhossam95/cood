

import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:equatable/equatable.dart';

sealed class GetPendingRequestState extends Equatable {
  const GetPendingRequestState();

  @override
  List<Object> get props => [];
}

final class GetPendingRequestInitial extends GetPendingRequestState {}

final class GetPendingRequestLoading extends GetPendingRequestState {
  final bool isLoading;

  const GetPendingRequestLoading({required this.isLoading});
}

final class GetPendingRequestSuccess extends GetPendingRequestState {
  final BaseListResponse response;

  const GetPendingRequestSuccess({required this.response});
}

final class GetPendingRequestFailure extends GetPendingRequestState {
  final String errorMessage;

  const GetPendingRequestFailure({required this.errorMessage});
}
