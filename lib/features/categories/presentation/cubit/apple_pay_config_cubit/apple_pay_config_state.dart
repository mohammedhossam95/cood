part of 'apple_pay_config_cubit.dart';

abstract class APayConfigState extends Equatable {
  const APayConfigState();

  @override
  List<Object?> get props => <Object?>[];
}

class APayConfigInitial extends APayConfigState {
  const APayConfigInitial();
}

class APayConfigLoading extends APayConfigState {
  final bool isLoading;
  const APayConfigLoading(this.isLoading);
}

class APayConfigSuccess extends APayConfigState {
  final CheckoutResponse response;
  const APayConfigSuccess({required this.response});
}

class APayConfigError extends APayConfigState {
  final String message;
  const APayConfigError({required this.message});
}
