import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/core/params/auth_params.dart';
import 'package:cood/features/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase editProfileUseCase;
  EditProfileCubit({required this.editProfileUseCase})
      : super(EditProfileInitial());
  bool isLoading = false;
  Future<void> editProfile(AuthParams params) async {
    changeLoadingView();
    try {
      Either<Failure, BaseOneResponse> response =
          await editProfileUseCase(params);
      changeLoadingView();
      emit(response.fold(
        (failure) => EditProfileError(msg: failure.toString()),
        (response) => EditProfileLoaded(response: response),
      ));
    } catch (e) {
      emit(EditProfileError(msg: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(EditProfileIsLoading(isLoading));
  }
}
