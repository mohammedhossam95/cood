import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/values/strings.dart';
import '../../../domain/usecases/verify_reset_password_usecase.dart';
import '../../../domain/entities/verify_reset_password_response.dart';

part 'verify_reset_password_states.dart';

class VerifyResetPasswordCubit extends Cubit<VerifyResetPasswordState> {
  final VerifyResetPasswordUseCase verifyResetPasswordUseCase;

  VerifyResetPasswordCubit(this.verifyResetPasswordUseCase) : super(const VerifyResetPasswordInitialState());


  Future<void> fVerifyResetPassword({
   required String email,
   required String code,
  }) async {
    emit(const VerifyResetPasswordLoadingState());
    final Either<Failure, VerifyResetPasswordResponse> eitherResult = await verifyResetPasswordUseCase(VerifyResetPasswordParams(
      email: email,
      code: code,
    ));
    eitherResult.fold((Failure failure) {
      emit(VerifyResetPasswordErrorState(message: failure.message?? Strings.pleaseTryAgainLater));
    }, (VerifyResetPasswordResponse response) {
      emit(const VerifyResetPasswordSuccessState());
    });
  }
}

