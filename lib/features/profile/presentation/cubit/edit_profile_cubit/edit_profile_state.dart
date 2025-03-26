part of 'edit_profile_cubit.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileIsLoading extends EditProfileState {
  final bool isLoading;
  const EditProfileIsLoading(this.isLoading);
}

class EditProfileLoaded extends EditProfileState {
  final BaseOneResponse response;

  const EditProfileLoaded({required this.response});
}

class EditProfileError extends EditProfileState {
  final String msg;

  const EditProfileError({required this.msg});
}
