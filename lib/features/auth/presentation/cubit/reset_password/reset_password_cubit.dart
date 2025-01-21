import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/values/strings.dart';
import '../../../domain/usecases/reset_password_usecase.dart';
import '../../../domain/entities/reset_password_response.dart';

part 'reset_password_states.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordCubit(this.resetPasswordUseCase) : super(const ResetPasswordInitialState());

  String? email;

  Future<void> fResetPassword({
   required String email,
  }) async {
    emit(const ResetPasswordLoadingState());
    final Either<Failure, ResetPasswordResponse> eitherResult = await resetPasswordUseCase(ResetPasswordParams(
      email: email,
    ));
    eitherResult.fold((Failure failure) {
      emit(ResetPasswordErrorState(message: failure.message?? Strings.pleaseTryAgainLater));
    }, (ResetPasswordResponse response) {
      this.email = email;
      emit(const ResetPasswordSuccessState());
    });
  }
}

