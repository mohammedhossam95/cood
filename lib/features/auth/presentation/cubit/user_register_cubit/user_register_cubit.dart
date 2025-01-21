import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '/features/auth/data/models/user_register_model.dart';
import '/features/auth/domain/usecases/user_register_usecase.dart';
import '../../../../../core/error/failures.dart';

part 'user_register_state.dart';

class UserRegisterCubit extends Cubit<UserRegisterState> {
  final UserRegisterUseCase userRegisterUseCase;
  bool isLoading = false;

  UserRegisterCubit(this.userRegisterUseCase) : super(UserRegisterInitial());
  Future<void> postUserData({required UserRegisterParams params}) async {
    changeLoadingView();
    try {
      changeLoadingView();
      Either<Failure, UserRegisterRespModel> result =
          await userRegisterUseCase.call(params);
      result.fold(
        (failure) =>
            emit(UserRegisterFailure(errorMessage: failure.message.toString())),
        (data) => emit(UserRegisterSuccess(resp: data)),
      );
    } catch (e) {
      emit(
        UserRegisterFailure(errorMessage: e.toString()),
      );
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(UserRegisterLoading(isLoading: isLoading));
  }
}
