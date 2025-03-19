import 'package:bloc/bloc.dart';
import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/core/error/failures.dart';
import 'package:cood/core/usecases/usecase.dart';
import 'package:cood/features/home/domain/usecases/get_user_social_media_use_case.dart';
import 'package:cood/features/home/presentation/cubit/get_user_social_media/get_user_social_media_state.dart';
import 'package:dartz/dartz.dart';

class GetUserSocialMediaCubit extends Cubit<GetUserSocialMediaState> {
  final GetUserSocialMediaUseCase getUserSocialMediaUseCase;
  GetUserSocialMediaCubit(this.getUserSocialMediaUseCase)
      : super(GetUserSocialMediaInitial());
  bool isLoading = false;
  void changeLoadingView() {
    isLoading = !isLoading;
    emit(GetUserSocialMediaLoading(isLoading: isLoading));
  }

//--------------this will call in this function getCurrentTapBarWidget;
  Future<void> getUserSocialMedia() async {
    changeLoadingView();
    try {
      changeLoadingView();
      Either<Failure, BaseListResponse> result =
          await getUserSocialMediaUseCase.call(NoParams());
      emit(
        result.fold(
          (failure) =>
              GetUserSocialMediaFailure(errorMessage: failure.message.toString()),
          (resp) => GetUserSocialMediaSuccerss(response: resp),
        ),
      );
    } catch (e) {
      emit(GetUserSocialMediaFailure(errorMessage: e.toString()));
    }
  }
}
