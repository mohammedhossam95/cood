

import 'package:cood/core/usecases/usecase.dart';
import 'package:cood/features/home/domain/usecases/get_pending_requests_use_case.dart';
import 'package:cood/features/home/presentation/cubit/get_pending_requests/get_pending_request_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetPendingRequestCubit extends Cubit<GetPendingRequestState> {
  final GetPendingRequestUseCase getPendingRequestUseCase;
  GetPendingRequestCubit(this.getPendingRequestUseCase)
      : super(GetPendingRequestInitial());

  bool isLoading = false;
  void changeLoadingView() {
    isLoading = !isLoading;
    emit(GetPendingRequestLoading(isLoading: isLoading));
  }

  void emitInitial() {
    isLoading = !isLoading;
    emit(GetPendingRequestInitial());
  }

//--------------this will call in this function GetPendingRequest;
  Future<void> getPendingRequest() async {
    try {
        changeLoadingView();
      final result = await getPendingRequestUseCase.call(NoParams());
      emit(
        result.fold(
          (failure) => GetPendingRequestFailure(
              errorMessage: failure.message.toString()),
          (resp) => GetPendingRequestSuccess(response: resp),
        ),
      );
    } catch (e) {
      emit(GetPendingRequestFailure(errorMessage: e.toString()));
    }
  }
}
