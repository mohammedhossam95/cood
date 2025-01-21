part of 'landery_register_cubit.dart';

sealed class LanderyRegisterState extends Equatable {
  const LanderyRegisterState();

  @override
  List<Object> get props => [];
}

final class LanderyRegisterInitial extends LanderyRegisterState {}

final class LanderyRegisterLoadingState extends LanderyRegisterState {
  final bool isLoading;

  const LanderyRegisterLoadingState({required this.isLoading});
  @override
  List<Object> get props => [isLoading];
}

final class LanderyRegisterSuccessState extends LanderyRegisterState {
  final BaseOneResponse resp;

  const LanderyRegisterSuccessState({required this.resp});
  @override
  List<Object> get props => [resp];
}

final class LanderyRegisterFailureState extends LanderyRegisterState {
  final String errorMessage;

  const LanderyRegisterFailureState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
