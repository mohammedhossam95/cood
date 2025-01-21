part of 'delivery_register_cubit.dart';

sealed class DeliveryRegisterState extends Equatable {
  const DeliveryRegisterState();

  @override
  List<Object> get props => [];
}

final class DeliveryRegisterInitial extends DeliveryRegisterState {}

final class DeliveryRegisterLoading extends DeliveryRegisterState {
  final bool isLoading;

  const DeliveryRegisterLoading({required this.isLoading});
}

final class DeliveryRegisterSuccess extends DeliveryRegisterState {
  final DeliveryRegisterRespModel resp;

  const DeliveryRegisterSuccess({required this.resp});
}

final class DeliveryRegisterFailurte extends DeliveryRegisterState {
  final String errorMessage;

  const DeliveryRegisterFailurte({required this.errorMessage});
}
