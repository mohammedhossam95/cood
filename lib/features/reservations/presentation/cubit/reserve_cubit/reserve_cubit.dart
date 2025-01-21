import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/params/car_params.dart';
import '/features/reservations/domain/use_case/make_reserve_usecase.dart';
import '../../../../../core/error/failures.dart';

part 'reserve_state.dart';

class ReserveCubit extends Cubit<ReserveState> {
  final MakeReserveUseCase makeReserveUseCase;

  ReserveCubit({required this.makeReserveUseCase})
      : super(const ReserveInitial());
  bool isLoading = false;
  Future<void> fReserve(CarParams params) async {
    changeLoadingView();
    try {
      Either<Failure, BaseOneResponse> response =
          await makeReserveUseCase(params);
      changeLoadingView();

      emit(response.fold(
        (failure) => ReserveError(message: failure.toString()),
        (resp) {
          if (resp.statusCode == 200) {
            return ReserveSuccess(response: resp);
          } else {
            return ReserveError(message: resp.message.toString());
          }
        },
      ));
    } catch (e) {
      emit(ReserveError(message: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(ReserveLoading(isLoading));
  }
}
