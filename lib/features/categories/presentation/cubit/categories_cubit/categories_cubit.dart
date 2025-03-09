import 'dart:developer';

import 'package:cood/features/categories/data/model/plans_model.dart';
import 'package:cood/features/categories/domain/use_case/categories_use_case.dart';
import 'package:cood/features/categories/domain/use_case/additional_use_case.dart';
import 'package:cood/features/categories/domain/use_case/get_plans_usecase.dart';
import 'package:cood/features/categories/presentation/cubit/categories_cubit/categories_data_cubit.dart';
import 'package:cood/features/categories/presentation/cubit/categories_cubit/categories_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/base_classes/base_one_response.dart';
import '/core/error/failures.dart';
import '/core/services/local_storage/app_shared_preferences.dart';
import '/core/usecases/usecase.dart';

import '/injection_container.dart';
import '../../../data/model/additional_model.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  bool isLoading = false;
  final CategoriesUseCase categoriesUseCase;
  final GetPlansUseCase getPlansUseCase;
  final GetAdditionalUseCase getAdditionalUseCase;

  CategoriesCubit(
      this.categoriesUseCase, this.getPlansUseCase, this.getAdditionalUseCase)
      : super(CategoriesInitial());

  AppSharedPreferences get sharedPreferences =>
      ServiceLocator.instance<AppSharedPreferences>();
  List<String> plans = [];

  Future<void> getCategoriess() async {
    changeLoadingView();
    try {
      changeLoadingView();
      Either<Failure, BaseListResponse> result =
          await categoriesUseCase.call(NoParams());
      emit(
        result.fold(
            (failure) =>
                CategoriesFailure(errorMessage: failure.message.toString()),
            (resp) => CategoriesSuccerss(response: resp)),
      );
    } catch (e) {
      emit(CategoriesFailure(errorMessage: e.toString()));
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
                CategoriesFailure(errorMessage: failure.message.toString()),
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
      Either<Failure, BaseOneResponse> result =
          await getPlansUseCase(NoParams());
      emit(
        result.fold(
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
    emit(CategoriesLoading(isLoading: isLoading));
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
        format.parse(BlocProvider.of<CategoriesDataCubit>(context).startDate!);

    if (selectedIndex == 0) {
      //total = 0;
      var newDate = DateTime(dateTime.year, dateTime.month + 1, dateTime.day);
      BlocProvider.of<CategoriesDataCubit>(context).endDate =
          DateFormat("dd-MM-yyyy").format(newDate);
      total += price[index];
      additionals.clear();
      addedValues.clear();
      emit(ChangeDeliveryTimeState());
    } else if (selectedIndex == 1) {
      //total = 0;
      var newDate = DateTime(dateTime.year, dateTime.month + 3, dateTime.day);
      BlocProvider.of<CategoriesDataCubit>(context).endDate =
          DateFormat("dd-MM-yyyy").format(newDate);
      total += price[index];
      additionals.clear();
      addedValues.clear();
      emit(ChangeDeliveryTimeState());
    } else if (selectedIndex == 2) {
      //total = 0;
      var newDate = DateTime(dateTime.year, dateTime.month + 6, dateTime.day);
      BlocProvider.of<CategoriesDataCubit>(context).endDate =
          DateFormat("dd-MM-yyyy").format(newDate);
      total += price[index];
      additionals.clear();
      addedValues.clear();
      emit(ChangeDeliveryTimeState());
    } else {
      //total = 0;
      var newDate = DateTime(dateTime.year, dateTime.month + 9, dateTime.day);
      BlocProvider.of<CategoriesDataCubit>(context).endDate =
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
