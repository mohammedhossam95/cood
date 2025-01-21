import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/error/failures.dart';
import '/features/auth/data/models/new_models/register_model.dart';
import '/features/auth/domain/usecases/new_usecases/register_usecase.dart';

part 'register_states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;
  bool isLoading = false;
  RegisterCubit(this.registerUseCase) : super(RegisterInitialState());

  Future<void> register({
    required RegisterParams params,
  }) async {
    changeLoadingView();
    try {
      changeLoadingView();
      Either<Failure, RegisterResponseModel> result =
          await registerUseCase.call(params);
      result.fold(
        (failure) =>
            emit(RegisterErrorState(errorMessage: failure.message.toString())),
        (data) => emit(RegisterSuccessState(resp: data)),
      );
    } catch (e) {
      emit(RegisterErrorState(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(RegisterLoadingState(isLoading: isLoading));
  }
}
