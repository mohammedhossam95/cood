import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:equatable/equatable.dart';

sealed class GetFriendsListState extends Equatable {
  const GetFriendsListState();

  @override
  List<Object> get props => [];
}

final class GetFriendsListInitial extends GetFriendsListState {}

final class GetFriendsListLoading extends GetFriendsListState {
  final bool isLoading;

  const GetFriendsListLoading({required this.isLoading});
}

final class GetFriendsListSuccerss extends GetFriendsListState {
  final BaseListResponse response;

  const GetFriendsListSuccerss({required this.response});
}

final class GetFriendsListFailure extends GetFriendsListState {
  final String errorMessage;

  const GetFriendsListFailure({required this.errorMessage});
}
