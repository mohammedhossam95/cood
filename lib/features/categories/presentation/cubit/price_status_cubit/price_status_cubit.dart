import 'package:cood/features/categories/domain/use_case/get_price_status_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/params/car_params.dart';
import '../../../../../core/error/failures.dart';

part 'price_status_state.dart';

class PriceStatusCubit extends Cubit<PriceStatusState> {
  final GetPriceStatusUseCase getPriceStatusUseCase;

  PriceStatusCubit({required this.getPriceStatusUseCase})
      : super(const PriceStatusInitial());
  bool isLoading = false;
  Future<void> getPriceStatus(CarParams params) async {
    changeLoadingView();
    try {
      Either<Failure, BaseOneResponse> response =
          await getPriceStatusUseCase(params);
      changeLoadingView();

      emit(response.fold(
        (failure) => PriceStatusError(message: failure.toString()),
        (resp) {
          if (resp.statusCode == 200) {
            return PriceStatusSuccess(response: resp);
          } else {
            return PriceStatusError(message: resp.message ?? '');
          }
        },
      ));
    } catch (e) {
      emit(PriceStatusError(message: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(PriceStatusLoading(isLoading));
  }
}
