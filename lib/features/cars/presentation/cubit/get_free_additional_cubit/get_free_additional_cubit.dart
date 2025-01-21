import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/params/car_params.dart';
import '/features/cars/domain/usecases/get_free_additional_usecase.dart';

part 'get_free_additional_state.dart';

class GetFreeAdditionalCubit extends Cubit<GetFreeAdditionalState> {
  final GetFreeAdditionalUsecase getFreeAdditionalUsecase;
  bool isLoading = false;
  GetFreeAdditionalCubit({required this.getFreeAdditionalUsecase})
      : super(GetFreeAdditionalInitial());
  Future<void> getFreeAdditional(CarParams params) async {
    changeLoading();
    try {
      final result = await getFreeAdditionalUsecase(params);
      changeLoading();
      emit(
        result.fold(
          (failure) => GetFreeAdditionalError(message: failure.message ?? ""),
          (response) => GetFreeAdditionalSuccess(response: response),
        ),
      );
    } catch (e) {
      emit(GetFreeAdditionalError(message: e.toString()));
    }
  }

  void changeLoading() {
    isLoading = !isLoading;
    emit(GetFreeAdditionalLoading(isLoading: isLoading));
  }
}
