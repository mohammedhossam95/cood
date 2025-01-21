import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/models/delivery_register_model.dart';
import '../../../domain/usecases/delivery_register_use_case.dart';

part 'delivery_register_state.dart';

class DeliveryRegisterCubit extends Cubit<DeliveryRegisterState> {
  final DeliveryRegisterUseCase deliveryRegisterUseCase;
  bool isLoading = false;
  DeliveryRegisterCubit({required this.deliveryRegisterUseCase})
      : super(DeliveryRegisterInitial());
  Future<void> postDeliveryData(
      {required DeliveryRegisterParams params}) async {
    changeLoadingView();

    try {
      changeLoadingView();
      final Either<Failure, DeliveryRegisterRespModel> result =
          await deliveryRegisterUseCase.call(params);
      result.fold(
        (failure) => emit(
            DeliveryRegisterFailurte(errorMessage: failure.message.toString())),
        (data) => emit(DeliveryRegisterSuccess(resp: data)),
      );
    } catch (e) {
      emit(DeliveryRegisterFailurte(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(DeliveryRegisterLoading(isLoading: isLoading));
  }
}
