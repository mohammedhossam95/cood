import 'package:cood/features/categories/domain/use_case/check_reserve_status_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/params/car_params.dart';
import '../../../../../core/error/failures.dart';

part 'coupon_validation_state.dart';

class CouponValidationCubit extends Cubit<CouponValidationState> {
  final CheckReserveUseCase checkReserveUseCase;

  CouponValidationCubit({required this.checkReserveUseCase})
      : super(const CouponValidationInitial());
  bool isLoading = false;
  Future<void> fCheckStatus(CarParams params) async {
    changeLoadingView();
    try {
      Either<Failure, BaseOneResponse> response =
          await checkReserveUseCase(params);
      changeLoadingView();

      emit(response.fold(
        (failure) => CouponValidationError(message: failure.toString()),
        (resp) {
          if (resp.statusCode == 200) {
            return CouponValidationSuccess(response: resp);
          } else {
            return CouponValidationError(message: resp.message.toString());
          }
        },
      ));
    } catch (e) {
      emit(CouponValidationError(message: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(CouponValidationLoading(isLoading));
  }
}
