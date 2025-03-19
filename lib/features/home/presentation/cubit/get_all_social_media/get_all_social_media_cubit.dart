import 'package:bloc/bloc.dart';
import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/core/error/failures.dart';
import 'package:cood/core/usecases/usecase.dart';
import 'package:cood/features/home/domain/usecases/get_all_social_media_use_case.dart';
import 'package:cood/features/home/presentation/cubit/get_all_social_media/get_All_social_media_state.dart';
import 'package:dartz/dartz.dart';

class GetAllSocialMediaCubit extends Cubit<GetAllSocialMediaState> {
  final GetAllSocialMediaUseCase getAllSocialMediaUseCase;
  GetAllSocialMediaCubit(this.getAllSocialMediaUseCase)
      : super(GetAllSocialMediaInitial());
  bool isLoading = false;
  void changeLoadingView() {
    isLoading = !isLoading;
    emit(GetAllSocialMediaLoading(isLoading: isLoading));
  }

//--------------this will call in this function getCurrentTapBarWidget;
  Future<void> getAllSocialMedia() async {
    changeLoadingView();
    try {
      changeLoadingView();
      Either<Failure, BaseListResponse> result =
          await getAllSocialMediaUseCase.call(NoParams());
      emit(
        result.fold(
          (failure) =>
              GetAllSocialMediaFailure(errorMessage: failure.message.toString()),
          (resp) => GetAllSocialMediaSuccerss(response: resp),
        ),
      );
    } catch (e) {
      emit(GetAllSocialMediaFailure(errorMessage: e.toString()));
    }
  }
}
