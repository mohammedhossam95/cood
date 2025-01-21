import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/values/strings.dart';
import '../../../domain/usecases/confirm_reset_password_usecase.dart';
import '../../../domain/entities/confirm_reset_password_response.dart';

part 'confirm_reset_password_states.dart';

class ConfirmResetPasswordCubit extends Cubit<ConfirmResetPasswordState> {
  final ConfirmResetPasswordUseCase confirmResetPasswordUseCase;

  ConfirmResetPasswordCubit(this.confirmResetPasswordUseCase) : super(const ConfirmResetPasswordInitialState());


  Future<void> fConfirmResetPassword({
   required String email,
   required String password,
   required String passwordConfirmation,
  }) async {
    emit(const ConfirmResetPasswordLoadingState());
    final Either<Failure, ConfirmResetPasswordResponse> eitherResult = await confirmResetPasswordUseCase(ConfirmResetPasswordParams(
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    ));
    eitherResult.fold((Failure failure) {
      emit(ConfirmResetPasswordErrorState(message: failure.message?? Strings.pleaseTryAgainLater));
    }, (ConfirmResetPasswordResponse response) {
      emit(const ConfirmResetPasswordSuccessState());
    });
  }
}

