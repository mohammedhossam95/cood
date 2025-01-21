import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/params/car_params.dart';
import '/features/cars/domain/usecases/get_additional_usecase.dart';

part 'get_additional_state.dart';

class GetAdditionalCubit extends Cubit<GetAdditionalState> {
  GetAdditionalUsecase getAdditionalUsecase;
  bool isLoading = false;
  GetAdditionalCubit({required this.getAdditionalUsecase})
      : super(GetAdditionalInitial());

  Future<void> getAdditional(CarParams params) async {
    changeLoading();
    try {
      final result = await getAdditionalUsecase(params);
      changeLoading();
      emit(
        result.fold(
          (failure) => GetAdditionalError(message: failure.message ?? ""),
          (response) => GetAdditionalSuccess(response: response),
        ),
      );
    } catch (e) {
      emit(GetAdditionalError(message: e.toString()));
    }
  }

  void changeLoading() {
    isLoading = !isLoading;
    emit(GetAdditionalLoading(isLoading: isLoading));
  }
}
