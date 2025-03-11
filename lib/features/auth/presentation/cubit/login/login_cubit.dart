import 'package:cood/core/params/auth_params.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/values/strings.dart';
import '../../../data/models/login_model.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_states.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginEmailUseCase loginEmailUseCase;
  bool isLoading = false;
  LoginCubit(this.loginEmailUseCase) : super(LoginInitialState());

  Future<void> fLoginPhone({required AuthParams params}) async {
    changeLoadingView();
    try {
      final Either<Failure, LoginRespModel> eitherResult =
          await loginEmailUseCase(params);
      eitherResult.fold((Failure failure) {
        emit(LoginErrorState(
            errorMessage: failure.message ?? Strings.pleaseTryAgainLater));
      }, (response) {
        emit(LoginSuccessState(resp: response));
      });
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading: isLoading));
  }
}
