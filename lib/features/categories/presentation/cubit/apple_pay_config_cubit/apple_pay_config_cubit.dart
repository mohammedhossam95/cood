import 'package:cood/features/categories/domain/entity/checkout_response.dart';
import 'package:cood/features/categories/domain/use_case/get_apple_config_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/params/car_params.dart';
import '../../../../../core/error/failures.dart';

part 'apple_pay_config_state.dart';

class APayConfigCubit extends Cubit<APayConfigState> {
  final GetAppleConfigUseCase getAppleConfigUseCase;

  APayConfigCubit({required this.getAppleConfigUseCase})
      : super(const APayConfigInitial());
  bool isLoading = false;
  Future<void> getCheckout(CarParams params) async {
    changeLoadingView();
    try {
      Either<Failure, CheckoutResponse> response =
          await getAppleConfigUseCase(params);
      changeLoadingView();

      emit(response.fold(
        (failure) => APayConfigError(message: failure.toString()),
        (resp) {
          if (resp.result?.code == "000.200.100") {
            return APayConfigSuccess(response: resp);
          } else {
            return APayConfigError(message: resp.result?.description ?? '');
          }
        },
      ));
    } catch (e) {
      emit(APayConfigError(message: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(APayConfigLoading(isLoading));
  }
}
