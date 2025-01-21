import 'package:equatable/equatable.dart';
import '/core/base_classes/base_list_response.dart';
import '/core/base_classes/base_one_response.dart';

sealed class ReservationState extends Equatable {
  const ReservationState();

  @override
  List<Object> get props => [];
}

final class ReservationInitial extends ReservationState {}

final class ReservationLoading extends ReservationState {
  final bool isLoading;

  const ReservationLoading({required this.isLoading});
}

final class ReservationSuccerss extends ReservationState {
  final BaseListResponse response;

  const ReservationSuccerss({required this.response});
}

final class AdditionalSuccess extends ReservationState {
  final BaseListResponse additionals;

  const AdditionalSuccess({required this.additionals});
}

final class PlansSuccess extends ReservationState {
  final BaseOneResponse response;

  const PlansSuccess({required this.response});
}

final class MonthlyPlan extends ReservationState {}

final class WeeklyPlan extends ReservationState {}

final class DailyPlan extends ReservationState {}

final class ReservationFailure extends ReservationState {
  final String errorMessage;

  const ReservationFailure({required this.errorMessage});
}

final class PlansFailure extends ReservationState {
  final String errorMessage;

  const PlansFailure({required this.errorMessage});
}

final class AdditionalFailure extends ReservationState {
  final String errorMessage;

  const AdditionalFailure({required this.errorMessage});
}

final class ChangeIndexState extends ReservationState {}

final class ChangeDeliveryTimeState extends ReservationState {}
