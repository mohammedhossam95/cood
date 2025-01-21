import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/params/car_params.dart';
import '/features/reservations/domain/use_case/check_reserve_status_usecase.dart';
import '../../../../../core/error/failures.dart';

part 'check_reserve_status_state.dart';

class CheckReserveStatusCubit extends Cubit<CheckReserveStatusState> {
  final CheckReserveUseCase checkReserveUseCase;

  CheckReserveStatusCubit({required this.checkReserveUseCase})
      : super(const CheckReserveStatusInitial());
  bool isLoading = false;
  Future<void> fCheckStatus(CarParams params) async {
    changeLoadingView();
    try {
      Either<Failure, BaseOneResponse> response =
          await checkReserveUseCase(params);
      changeLoadingView();

      emit(response.fold(
        (failure) => CheckReserveStatusError(message: failure.toString()),
        (resp) {
          if (resp.statusCode == 200) {
            return CheckReserveStatusSuccess(response: resp);
          } else {
            return CheckReserveStatusError(message: resp.message.toString());
          }
        },
      ));
    } catch (e) {
      emit(CheckReserveStatusError(message: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(CheckReserveStatusLoading(isLoading));
  }
}
