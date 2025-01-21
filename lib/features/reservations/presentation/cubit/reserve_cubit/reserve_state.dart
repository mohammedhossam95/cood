part of 'reserve_cubit.dart';

abstract class ReserveState extends Equatable {
  const ReserveState();

  @override
  List<Object?> get props => <Object?>[];
}

class ReserveInitial extends ReserveState {
  const ReserveInitial();
}

class ReserveLoading extends ReserveState {
  final bool isLoading;
  const ReserveLoading(this.isLoading);
}

class ReserveSuccess extends ReserveState {
  final BaseOneResponse response;
  const ReserveSuccess({required this.response});
}

class ReserveError extends ReserveState {
  final String message;
  const ReserveError({required this.message});
}
