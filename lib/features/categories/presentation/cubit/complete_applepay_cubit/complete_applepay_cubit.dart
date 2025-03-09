import 'package:cood/features/categories/domain/use_case/complete_applepay_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/params/car_params.dart';
import '../../../../../core/error/failures.dart';

part 'complete_applepay_state.dart';

class CompleteApplePayCubit extends Cubit<CompleteApplePayState> {
  final CompleteAPayUseCase completeAPayUseCase;

  CompleteApplePayCubit({required this.completeAPayUseCase})
      : super(const CompleteApplePayInitial());
  bool isLoading = false;
  Future<void> fComplete(CarParams params) async {
    changeLoadingView();
    try {
      Either<Failure, BaseOneResponse> response =
          await completeAPayUseCase(params);
      changeLoadingView();

      emit(response.fold(
        (failure) => CompleteApplePayError(message: failure.toString()),
        (resp) {
          if (resp.statusCode == 200) {
            return CompleteApplePaySuccess(response: resp);
          } else {
            return CompleteApplePayError(message: resp.message.toString());
          }
        },
      ));
    } catch (e) {
      emit(CompleteApplePayError(message: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(CompleteApplePayLoading(isLoading));
  }
}
