import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/error/failures.dart';
import '/core/utils/values/strings.dart';
import '/features/auth/data/models/new_models/login_model.dart';
import '/features/auth/domain/usecases/new_usecases/new_login_usecase.dart';

part 'new_login_states.dart';

class NewLoginCubit extends Cubit<NewLoginState> {
  final NewLoginUsecase newLoginUsecase;
  bool isLoading = false;
  NewLoginCubit(this.newLoginUsecase) : super(LoginInitialState());

  Future<void> login({
    required NewLoginParams params,
  }) async {
    changeLoadingView();
    try {
      final Either<Failure, LoginResponseModel> eitherResult =
          await newLoginUsecase(params);
      eitherResult.fold((Failure failure) {
        emit(NewLoginErrorState(
            errorMessage: failure.message ?? Strings.pleaseTryAgainLater));
      }, (response) {
        if (response.details != null) {
          if (response.details!.token!.isNotEmpty) {
            emit(NewLoginSuccessState(resp: response));
          } else {
            emit(NewLoginErrorState(errorMessage: Strings.enterCorrecData));
          }
        }

        // emit(LoginSuccessState(resp: response));
      });
    } catch (e) {
      emit(NewLoginErrorState(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(NewLoginLoadingState(isLoading: isLoading));
  }
}
