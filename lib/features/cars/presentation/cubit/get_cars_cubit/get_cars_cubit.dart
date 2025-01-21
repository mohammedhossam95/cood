import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/params/car_params.dart';
import '/features/cars/domain/usecases/get_cars_usecase.dart';

part 'get_cars_state.dart';

class GetCarsCubit extends Cubit<GetCarsState> {
  GetCarsUsecase getCarsUsecase;
  bool isLoading = false;
  GetCarsCubit({required this.getCarsUsecase}) : super(GetCarsInitial());

  Future<void> getCars({required CarParams params}) async {
    changeLoading();
    try {
      final result = await getCarsUsecase(params);
      changeLoading();
      emit(
        result.fold(
          (failure) => GetCarsError(message: failure.message ?? ""),
          (resp) => GetCarsSuccess(response: resp),
        ),
      );
    } catch (e) {
      emit(GetCarsError(message: e.toString()));
    }
  }

  void changeLoading() {
    isLoading = !isLoading;
    emit(GetCarsLoading(isLoading: isLoading));
  }
}
