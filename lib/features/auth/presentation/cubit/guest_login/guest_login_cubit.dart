import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/values/strings.dart';
import '../../../data/models/login_model.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'guest_login_state.dart';

class GuestLoginCubit extends Cubit<GuestLoginState> {
  final LoginEmailUseCase loginEmailUseCase;
  bool isLoading = false;
  GuestLoginCubit(this.loginEmailUseCase) : super(GuestLoginInitialState());

  Future<void> fLoginPhone({
    required LoginParams params,
  }) async {
    changeLoadingView();
    try {
      final Either<Failure, LoginRespModel> eitherResult =
          await loginEmailUseCase(params);
      eitherResult.fold((Failure failure) {
        emit(GuestLoginErrorState(
            errorMessage: failure.message ?? Strings.pleaseTryAgainLater));
      }, (response) {
        if (response.data?.userType != null) {
          if (params.userType!.toLowerCase() ==
              response.data?.userType!.toLowerCase()) {
            emit(GuestLoginSuccessState(resp: response));
          } else {
            emit(GuestLoginErrorState(errorMessage: Strings.enterCorrecData));
          }
        }
        // emit(LoginSuccessState(resp: response));
      });
    } catch (e) {
      emit(GuestLoginErrorState(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(GuestLoginLoadingState(isLoading: isLoading));
  }
}
