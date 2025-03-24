



import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:equatable/equatable.dart';

sealed class SendFriendRequestState extends Equatable {
  const SendFriendRequestState();

  @override
  List<Object> get props => [];
}

final class SendFriendRequestInitial extends SendFriendRequestState {}

final class SendFriendRequestLoading extends SendFriendRequestState {
  final bool isLoading;

  const SendFriendRequestLoading({required this.isLoading});
}

final class SendFriendRequestSuccess extends SendFriendRequestState {
  final BaseOneResponse response;

  const SendFriendRequestSuccess({required this.response});
}

final class SendFriendRequestFailure extends SendFriendRequestState {
  final String errorMessage;

  const SendFriendRequestFailure({required this.errorMessage});
}
