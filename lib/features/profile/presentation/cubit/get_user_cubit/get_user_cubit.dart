import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/usecases/usecase.dart';
import '/features/profile/domain/usecases/get_user_usecase.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserUsecase getUserUsecase;
  bool isLoading = false;
  GetUserCubit({required this.getUserUsecase}) : super(GetUserInitial());

  Future<void> getUSer() async {
    changeLoading();
    try {
      final result = await getUserUsecase(NoParams());
      changeLoading();
      emit(
        result.fold(
          (failure) => GetUserError(message: failure.message ?? ""),
          (resp) => GetUserSuccess(response: resp),
        ),
      );
    } catch (e) {
      emit(GetUserError(message: e.toString()));
    }
  }

  void changeLoading() {
    isLoading = !isLoading;
    emit(GetUserLoading(isLoading: isLoading));
  }
}
