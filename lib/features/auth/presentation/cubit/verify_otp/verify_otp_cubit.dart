import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/core/params/auth_params.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/values/strings.dart';
import '../../../domain/usecases/verify_otp_usecase.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  bool isLoading = false;
  VerifyOtpCubit(this.verifyOtpUseCase) : super(VerifyOtpInitialState());

  Future<void> fVerifyOtp({required AuthParams params}) async {
    changeLoadingView();
    try {
      final Either<Failure, BaseOneResponse> eitherResult =
          await verifyOtpUseCase(params);
      changeLoadingView();
      eitherResult.fold(
          (Failure failure) => emit(VerifyOtpError(
              errorMessage: failure.message ?? Strings.pleaseTryAgainLater)),
          (response) => emit(VerifyOtpSuccess(resp: response)));
    } catch (e) {
      emit(VerifyOtpError(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(VerifyOtpLoading(isLoading: isLoading));
  }
}
