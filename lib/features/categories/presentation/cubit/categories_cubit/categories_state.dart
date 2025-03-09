import 'package:equatable/equatable.dart';
import '/core/base_classes/base_list_response.dart';
import '/core/base_classes/base_one_response.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {
  final bool isLoading;

  const CategoriesLoading({required this.isLoading});
}

final class CategoriesSuccerss extends CategoriesState {
  final BaseListResponse response;

  const CategoriesSuccerss({required this.response});
}

final class AdditionalSuccess extends CategoriesState {
  final BaseListResponse additionals;

  const AdditionalSuccess({required this.additionals});
}

final class PlansSuccess extends CategoriesState {
  final BaseOneResponse response;

  const PlansSuccess({required this.response});
}

final class MonthlyPlan extends CategoriesState {}

final class WeeklyPlan extends CategoriesState {}

final class DailyPlan extends CategoriesState {}

final class CategoriesFailure extends CategoriesState {
  final String errorMessage;

  const CategoriesFailure({required this.errorMessage});
}

final class PlansFailure extends CategoriesState {
  final String errorMessage;

  const PlansFailure({required this.errorMessage});
}

final class AdditionalFailure extends CategoriesState {
  final String errorMessage;

  const AdditionalFailure({required this.errorMessage});
}

final class ChangeIndexState extends CategoriesState {}

final class ChangeDeliveryTimeState extends CategoriesState {}
