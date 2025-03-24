
import 'package:cood/features/home/domain/usecases/send_friend_request_use_case.dart';
import 'package:cood/features/home/presentation/cubit/send_friend_request/send_friend_request_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendFriendRequestCubit extends Cubit<SendFriendRequestState> {
  final SendFreindRequestUseCase sendFreindRequestUseCase;
  SendFriendRequestCubit(this.sendFreindRequestUseCase)
      : super(SendFriendRequestInitial());
  bool isLoading = false;
  void changeLoadingView() {
    isLoading = !isLoading;
    emit(SendFriendRequestLoading(isLoading: isLoading));
  }

  void emitInitial() {
    isLoading = !isLoading;
    emit(SendFriendRequestInitial());
  }

//--------------this will call in this function SendFriendRequest;
  Future<void> sendFriendRequest(int id) async {
    try {
        changeLoadingView();
      final result = await sendFreindRequestUseCase.call(id);
      emit(
        result.fold(
          (failure) => SendFriendRequestFailure(
              errorMessage: failure.message.toString()),
          (resp) => SendFriendRequestSuccess(response: resp),
        ),
      );
    } catch (e) {
      emit(SendFriendRequestFailure(errorMessage: e.toString()));
    }
  }
}
