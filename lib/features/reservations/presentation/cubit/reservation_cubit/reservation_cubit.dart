import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/base_classes/base_one_response.dart';
import '/core/error/failures.dart';
import '/core/services/local_storage/app_shared_preferences.dart';
import '/core/usecases/usecase.dart';
import '/features/reservations/data/model/plans_model.dart';
import '/features/reservations/domain/use_case/additional_use_case.dart';
import '/features/reservations/domain/use_case/get_plans_usecase.dart';
import '/features/reservations/domain/use_case/reservation_use_case.dart';
import '/features/reservations/presentation/cubit/reservation_cubit/reservation_data_cubit.dart';
import '/features/reservations/presentation/cubit/reservation_cubit/reservation_state.dart';
import '/injection_container.dart';
import '../../../data/model/additional_model.dart';

class ReservationCubit extends Cubit<ReservationState> {
  bool isLoading = false;
  final ReservationUseCase reservationUseCase;
  final GetPlansUseCase getPlansUseCase;
  final GetAdditionalUseCase getAdditionalUseCase;

  ReservationCubit(
      this.reservationUseCase, this.getPlansUseCase, this.getAdditionalUseCase)
      : super(ReservationInitial());

  AppSharedPreferences get sharedPreferences =>
      ServiceLocator.instance<AppSharedPreferences>();
  List<String> plans = [];

  Future<void> getReservations() async {
    changeLoadingView();
    try {
      changeLoadingView();
      Either<Failure, BaseListResponse> resulr =
          await reservationUseCase.call(NoParams());
      emit(
        resulr.fold(
            (failure) =>
                ReservationFailure(errorMessage: failure.message.toString()),
            (resp) => ReservationSuccerss(response: resp)),
      );
    } catch (e) {
      emit(ReservationFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getAdditional(categoryId) async {
    changeLoadingView();
    try {
      changeLoadingView();
      Either<Failure, BaseListResponse> result =
          await getAdditionalUseCase.call(categoryId);
      log(result.toString());
      emit(
        result.fold(
            (failure) =>
                ReservationFailure(errorMessage: failure.message.toString()),
            (resp) => AdditionalSuccess(additionals: resp)),
      );
    } catch (e) {
      emit(AdditionalFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getPlans() async {
    changeLoadingView();
    try {
      changeLoadingView();
      Either<Failure, BaseOneResponse> resulr =
          await getPlansUseCase(NoParams());
      emit(
        resulr.fold(
            (failure) => PlansFailure(errorMessage: failure.message.toString()),
            (resp) {
          plans = [];
          PlansDetails plansData = resp.data;
          if (plansData.daily == true) {
            plans.add('Daily');
          }
          if (plansData.weekly == true) {
            plans.add('Weekly');
          }
          if (plansData.monthly == true) {
            plans.add('Monthly');
          }
          return PlansSuccess(response: resp);
        }),
      );
    } catch (e) {
      emit(PlansFailure(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(ReservationLoading(isLoading: isLoading));
  }

  void changePlane(String plan) {
    if (plan == 'Daily') {
      emit(DailyPlan());
    } else if (plan == 'Weekly') {
      emit(WeeklyPlan());
    } else {
      emit(MonthlyPlan());
    }
  }

  int selectedIndex = 0;
  String title = '';
  int total = 0;
  List<AdditionalDetail> additionals = [];
  List<AdditionalDetail> addedValues = [];
  changeSelectedIndex(int index, context, List<int> price) {
    selectedIndex = index;
    title = selectedIndex.toString();
    total = 0;

    DateFormat format = DateFormat("dd-MM-yyyy");
    DateTime dateTime =
        format.parse(BlocProvider.of<ReservationDataCubit>(context).startDate!);

    if (selectedIndex == 0) {
      //total = 0;
      var newDate = DateTime(dateTime.year, dateTime.month + 1, dateTime.day);
      BlocProvider.of<ReservationDataCubit>(context).endDate =
          DateFormat("dd-MM-yyyy").format(newDate);
      total += price[index];
      additionals.clear();
      addedValues.clear();
      emit(ChangeDeliveryTimeState());
    } else if (selectedIndex == 1) {
      //total = 0;
      var newDate = DateTime(dateTime.year, dateTime.month + 3, dateTime.day);
      BlocProvider.of<ReservationDataCubit>(context).endDate =
          DateFormat("dd-MM-yyyy").format(newDate);
      total += price[index];
      additionals.clear();
      addedValues.clear();
      emit(ChangeDeliveryTimeState());
    } else if (selectedIndex == 2) {
      //total = 0;
      var newDate = DateTime(dateTime.year, dateTime.month + 6, dateTime.day);
      BlocProvider.of<ReservationDataCubit>(context).endDate =
          DateFormat("dd-MM-yyyy").format(newDate);
      total += price[index];
      additionals.clear();
      addedValues.clear();
      emit(ChangeDeliveryTimeState());
    } else {
      //total = 0;
      var newDate = DateTime(dateTime.year, dateTime.month + 9, dateTime.day);
      BlocProvider.of<ReservationDataCubit>(context).endDate =
          DateFormat("dd-MM-yyyy").format(newDate);
      total += price[index];
      additionals.clear();
      addedValues.clear();
      emit(ChangeDeliveryTimeState());
    }
    emit(ChangeIndexState());
  }

  changeTotal(int value) {
    total = value;
    emit(ChangeIndexState());
  }
}
