part of 'complete_applepay_cubit.dart';

abstract class CompleteApplePayState extends Equatable {
  const CompleteApplePayState();

  @override
  List<Object?> get props => <Object?>[];
}

class CompleteApplePayInitial extends CompleteApplePayState {
  const CompleteApplePayInitial();
}

class CompleteApplePayLoading extends CompleteApplePayState {
  final bool isLoading;
  const CompleteApplePayLoading(this.isLoading);
}

class CompleteApplePaySuccess extends CompleteApplePayState {
  final BaseOneResponse response;
  const CompleteApplePaySuccess({required this.response});
}

class CompleteApplePayError extends CompleteApplePayState {
  final String message;
  const CompleteApplePayError({required this.message});
}
