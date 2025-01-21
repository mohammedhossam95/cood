import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/error/failures.dart';
import '/features/auth/data/models/new_models/verify_code_model.dart';
import '/features/auth/domain/usecases/new_usecases/verify_code_usecase.dart';

part 'verify_code_states.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  final VerifyCodeUsecase verifyCodeUseCase;
  bool isLoading = false;
  VerifyCodeCubit(this.verifyCodeUseCase) : super(VerifyCodeInitialState());

  Future<void> verifyCode({
    required VerifyCodeParams params,
  }) async {
    changeLoadingView();
    try {
      changeLoadingView();
      Either<Failure, VerifyCodeResponseModel> result =
          await verifyCodeUseCase.call(params);
      result.fold(
        (failure) => emit(
            VerifyCodeErrorState(errorMessage: failure.message.toString())),
        (data) => emit(VerifyCodeSuccessState(resp: data)),
      );
    } catch (e) {
      emit(VerifyCodeErrorState(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(VerifyCodeLoadingState(isLoading: isLoading));
  }
}
