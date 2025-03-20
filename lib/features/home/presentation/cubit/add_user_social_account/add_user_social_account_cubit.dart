// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:cood/core/params/add_user_account.dart';
import 'package:cood/features/home/domain/usecases/add_user_account_use_case.dart';
import 'package:cood/features/home/presentation/cubit/add_user_social_account/add_user_social_account_state.dart';

class AddUserSocialAccountCubit extends Cubit<AddUserSocialAccountState> {
  final AddUserSocialAccountUseCase addUserSocialAccountuseCase;
  AddUserSocialAccountCubit(
    this.addUserSocialAccountuseCase,
  ) : super(AddUserSocialAccountInitial());

  bool isLoading = false;

  Future<void> addUserSocialAccount(AddAccountParams param) async {
    changeLoadingView();
    try {
      final result = await addUserSocialAccountuseCase(param);
      changeLoadingView();
      emit(result.fold(
          (failure) =>
              AddUserSocialAccountFailure(errorMessage: failure.message ?? ''),
          (resp) => AddUserSocialAccountSuccess(response: resp)));
    } catch (e) {
      emit(AddUserSocialAccountFailure(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(AddUserSocialAccountLoading(isLoading: isLoading));
  }

  void emitIntial() {
    if (state is! AddUserSocialAccountInitial) {
      emit(AddUserSocialAccountInitial());
    }
  }
}
