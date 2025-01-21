part of 'price_status_cubit.dart';

abstract class PriceStatusState extends Equatable {
  const PriceStatusState();

  @override
  List<Object?> get props => <Object?>[];
}

class PriceStatusInitial extends PriceStatusState {
  const PriceStatusInitial();
}

class PriceStatusLoading extends PriceStatusState {
  final bool isLoading;
  const PriceStatusLoading(this.isLoading);
}

class PriceStatusSuccess extends PriceStatusState {
  final BaseOneResponse response;
  const PriceStatusSuccess({required this.response});
}

class PriceStatusError extends PriceStatusState {
  final String message;
  const PriceStatusError({required this.message});
}
