import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:equatable/equatable.dart';

sealed class AddUserSocialAccountState extends Equatable {
  const AddUserSocialAccountState();

  @override
  List<Object> get props => [];
}

final class AddUserSocialAccountInitial extends AddUserSocialAccountState {}

final class AddUserSocialAccountLoading extends AddUserSocialAccountState {
  final bool isLoading;

  const AddUserSocialAccountLoading({required this.isLoading});
}

final class AddUserSocialAccountSuccerss extends AddUserSocialAccountState {
  final BaseListResponse response;

  const AddUserSocialAccountSuccerss({required this.response});
}

final class AddUserSocialAccountFailure extends AddUserSocialAccountState {
  final String errorMessage;

  const AddUserSocialAccountFailure({required this.errorMessage});
}

