import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/base_classes/base_one_response.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/values/strings.dart';
import '../../../../../injection_container.dart';
import '../../../domain/usecases/logout_usecase.dart';
import '../auto_login/auto_login_cubit.dart';

part 'logout_states.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUseCase logoutUseCase;
  bool isLoading = false;
  LogoutCubit({required this.logoutUseCase})
      : super(const LogoutInitialState());

  Future<void> fLogout({required LogOutParams params}) async {
    changeLoadingView();

    try {
      final Either<Failure, BaseOneResponse> eitherResult =
          await logoutUseCase(params);
      eitherResult.fold((Failure failure) {
        emit(LogoutErrorState(
            errorMessage: failure.message ?? Strings.pleaseTryAgainLater));
      }, (data) {
        ServiceLocator.instance<AutoLoginCubit>().fLogout();
        emit(LogoutSuccessState(resp: data));
      });
    } catch (e) {
      emit(LogoutErrorState(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(LogoutLoadingState(isLoading: isLoading));
  }
}
