import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:equatable/equatable.dart';

sealed class GetUserSocialMediaState extends Equatable {
  const GetUserSocialMediaState();

  @override
  List<Object> get props => [];
}

final class GetUserSocialMediaInitial extends GetUserSocialMediaState {}

final class GetUserSocialMediaLoading extends GetUserSocialMediaState {
  final bool isLoading;

  const GetUserSocialMediaLoading({required this.isLoading});
}

final class GetUserSocialMediaSuccerss extends GetUserSocialMediaState {
  final BaseListResponse response;

  const GetUserSocialMediaSuccerss({required this.response});
}

final class GetUserSocialMediaFailure extends GetUserSocialMediaState {
  final String errorMessage;

  const GetUserSocialMediaFailure({required this.errorMessage});
}
