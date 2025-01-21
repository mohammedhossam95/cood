import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/error/failures.dart';
import '/features/auth/data/models/new_models/pre_register_model.dart';
import '/features/auth/domain/usecases/new_usecases/pre_register_usecase.dart';

part 'pre_register_states.dart';

class PreRegisterCubit extends Cubit<PreRegisterState> {
  final PreRegisterUsecase preRegisterUseCase;
  bool isLoading = false;
  PreRegisterCubit(this.preRegisterUseCase) : super(PreRegisterInitialState());

  Future<void> preRegister({
    required PreRegisterParams params,
  }) async {
    changeLoadingView();
    try {
      changeLoadingView();
      Either<Failure, PreRegisterResponseModel> result =
          await preRegisterUseCase.call(params);
      result.fold(
        (failure) => emit(
            PreRegisterErrorState(errorMessage: failure.message.toString())),
        (data) => emit(PreRegisterSuccessState(resp: data)),
      );
    } catch (e) {
      emit(PreRegisterErrorState(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(PreRegisterLoadingState(isLoading: isLoading));
  }
}
