import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/values/strings.dart';
import '../../../data/models/verify_otp_model.dart';
import '../../../domain/usecases/verify_otp_usecase.dart';

part 'verify_otp_states.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  bool isLoading = false;
  bool? isRegister;
  String? mobileWithCallingCode;
  String? mobile;
  String? callingCode;
  VerifyOtpCubit(this.verifyOtpUseCase) : super(VerifyOtpInitialState());

  Future<void> fVerifyOtp({
    required VerifyOtpParams params,
  }) async {
    changeLoadingView();
    try {
      final Either<Failure, ConfirmCodeAuthRespModel> eitherResult =
          await verifyOtpUseCase(params);
      changeLoadingView();
      eitherResult.fold((Failure failure) {
        emit(VerifyOtpErrorState(
            errorMessage: failure.message ?? Strings.pleaseTryAgainLater));
      }, (response) {
        emit(VerifyOtpSuccessState(
          resp: response,
        ));
      });
    } catch (e) {
      emit(VerifyOtpErrorState(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(VerifyOtpLoadingState(isLoading: isLoading));
  }

  void setMobileNumberWithCallingCode(String mobileNumber) {
    mobileWithCallingCode = mobileNumber;
    emit(VerifyOtpInitialState());
  }

  void setMobileNumber(String mobileNumber) {
    mobile = mobileNumber;
    emit(VerifyOtpInitialState());
  }

  void setCallingCode(String value) {
    callingCode = value;
    emit(VerifyOtpInitialState());
  }
}
