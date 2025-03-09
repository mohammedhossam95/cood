part of 'check_reserve_status_cubit.dart';

abstract class CheckReserveStatusState extends Equatable {
  const CheckReserveStatusState();

  @override
  List<Object?> get props => <Object?>[];
}

class CheckReserveStatusInitial extends CheckReserveStatusState {
  const CheckReserveStatusInitial();
}

class CheckReserveStatusLoading extends CheckReserveStatusState {
  final bool isLoading;
  const CheckReserveStatusLoading(this.isLoading);
}

class CheckReserveStatusSuccess extends CheckReserveStatusState {
  final BaseOneResponse response;
  const CheckReserveStatusSuccess({required this.response});
}

class CheckReserveStatusError extends CheckReserveStatusState {
  final String message;
  const CheckReserveStatusError({required this.message});
}
