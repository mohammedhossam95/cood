import 'package:bloc/bloc.dart';
import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/core/error/failures.dart';
import 'package:cood/core/usecases/usecase.dart';
import 'package:cood/features/home/domain/usecases/get_all_user_gallary_use_case.dart';
import 'package:cood/features/home/presentation/cubit/get_all_user_gallary/get_user_gallary_states.dart';
import 'package:dartz/dartz.dart';

class GetUserGallaryCubit extends Cubit<GetUserGallaryState> {
  final GetAllUserGallaryUseCase getAllUserGallaryUseCase;
  GetUserGallaryCubit(this.getAllUserGallaryUseCase)
      : super(GetUserGallaryInitial());
  bool isLoading = false;
  void changeLoadingView() {
    isLoading = !isLoading;
    emit(GetUserGallaryLoading(isLoading: isLoading));
  }

//--------------this will call in this function getCurrentTapBarWidget;
  Future<void> getAllUserGallary() async {
    changeLoadingView();
    try {
      changeLoadingView();
      Either<Failure, BaseListResponse> result =
          await getAllUserGallaryUseCase.call(NoParams());
      emit(
        result.fold(
          (failure) =>
              GetUserGallaryFailure(errorMessage: failure.message.toString()),
          (resp) => GetUserGallarySuccerss(response: resp),
        ),
      );
    } catch (e) {
      print('allllllllllll${e.toString()}');
      emit(GetUserGallaryFailure(errorMessage: e.toString()));
    }
  }
}
