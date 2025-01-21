import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/error/failures.dart';
import '/features/auth/domain/usecases/landery_register_use_case.dart';

part 'landery_register_state.dart';

class LanderyRegisterCubit extends Cubit<LanderyRegisterState> {
  bool isLoading = false;
  final LanderyRegisterUseCase landeryRegisterUseCase;
  LanderyRegisterCubit({required this.landeryRegisterUseCase})
      : super(LanderyRegisterInitial());
  Future<void> getLanderyData({required LanderyRegisterParams params}) async {
    changeLoadingView();
    try {
      changeLoadingView();
      Either<Failure, BaseOneResponse> result =
          await landeryRegisterUseCase.call(params);
      result.fold(
        (failure) => emit(
            LanderyRegisterFailureState(errorMessage: failure.message ?? "")),
        (landeryData) => emit(LanderyRegisterSuccessState(resp: landeryData)),
      );
    } catch (e) {
      emit(LanderyRegisterFailureState(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(LanderyRegisterLoadingState(isLoading: isLoading));
  }
}
