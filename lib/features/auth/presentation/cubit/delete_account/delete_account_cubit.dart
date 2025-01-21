import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/base_classes/base_one_response.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/values/strings.dart';
import '../../../domain/usecases/delete_account_usecase.dart';

part 'delete_account_states.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final DeleteAccountUseCase deleteAccountUseCase;
  bool isLoading = false;
  DeleteAccountCubit(this.deleteAccountUseCase)
      : super(const DeleteAccountInitialState());

  Future<void> fDeleteAccount() async {
    changeLoadingView();

    try {
      changeLoadingView();
      final Either<Failure, BaseOneResponse> eitherResult =
          await deleteAccountUseCase(NoParams());
      eitherResult.fold((Failure failure) {
        emit(DeleteAccountErrorState(
            message: failure.message ?? Strings.pleaseTryAgainLater));
      }, (BaseOneResponse response) {
        emit(DeleteAccountSuccessState(resp: response));
      });
    } catch (e) {
      emit(DeleteAccountErrorState(message: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(DeleteAccountLoadingState(isLoading: isLoading));
  }
}
