import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:equatable/equatable.dart';

sealed class GetAllSocialMediaState extends Equatable {
  const GetAllSocialMediaState();

  @override
  List<Object> get props => [];
}

final class GetAllSocialMediaInitial extends GetAllSocialMediaState {}

final class GetAllSocialMediaLoading extends GetAllSocialMediaState {
  final bool isLoading;

  const GetAllSocialMediaLoading({required this.isLoading});
}

final class GetAllSocialMediaSuccerss extends GetAllSocialMediaState {
  final BaseListResponse response;

  const GetAllSocialMediaSuccerss({required this.response});
}

final class GetAllSocialMediaFailure extends GetAllSocialMediaState {
  final String errorMessage;

  const GetAllSocialMediaFailure({required this.errorMessage});
}
