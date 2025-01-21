import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/usecases/usecase.dart';
import '/features/home/domain/usecases/get_plans_status_usecase.dart';

part 'get_plans_status_state.dart';

class GetPlansStatusCubit extends Cubit<GetPlansStatusState> {
  GetPlansStatusUsecase getPlansStatusUsecase;
  bool isLoading = false;
  GetPlansStatusCubit({required this.getPlansStatusUsecase})
      : super(GetPlansStatusInitial());

  Future<void> getPlansStatus() async {
    changeLoading();
    try {
      final result = await getPlansStatusUsecase(NoParams());
      changeLoading();
      emit(
        result.fold(
          (failure) => GetPlansStatusError(message: failure.message ?? ""),
          (resp) => GetPlansStatusSuccess(response: resp),
        ),
      );
    } catch (e) {
      emit(GetPlansStatusError(message: e.toString()));
    }
  }

  void changeLoading() {
    isLoading = !isLoading;
    emit(GetPlansStatusLoading(isLoading: isLoading));
  }
}
