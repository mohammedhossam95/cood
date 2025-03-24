import 'package:bloc/bloc.dart';
import 'package:cood/features/home/domain/usecases/search_user_by_code_use_case.dart';
import 'package:cood/features/home/presentation/cubit/get_search_user_by_code/get_search_user_by_code_state.dart';

class GetSearchUserByCodeCubit extends Cubit<GetSearchUserByCodeState> {
  final GetSearchUserByCodeUseCase getSearchUserByCodeUseCase;
  GetSearchUserByCodeCubit(this.getSearchUserByCodeUseCase)
      : super(GetSearchUserByCodeInitial());
  bool isLoading = false;
  void changeLoadingView() {
    isLoading = !isLoading;
    emit(GetSearchUserByCodeLoading(isLoading: isLoading));
  }

  void emitInitial() {
    isLoading = !isLoading;
    emit(GetSearchUserByCodeInitial());
  }

//--------------this will call in this function getSearchUserByCode;
  Future<void> getSearchUserByCode(String params) async {
    //changeLoadingView();
    try {
        changeLoadingView();
      final result = await getSearchUserByCodeUseCase.call(params);
      emit(
        result.fold(
          (failure) => GetSearchUserByCodeFailure(
              errorMessage: failure.message.toString()),
          (resp) => GetSearchUserByCodeSuccess(response: resp),
        ),
      );
    } catch (e) {
      emit(GetSearchUserByCodeFailure(errorMessage: e.toString()));
    }
  }
}
