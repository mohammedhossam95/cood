// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/core/error/failures.dart';
import 'package:cood/features/categories/domain/use_case/get_filter_users_by_category_use_case.dart';
import 'package:cood/features/categories/presentation/cubit/get_filter_user_by_category/get_filter_user_by_category_state.dart';
import 'package:dartz/dartz.dart';

class GetFilterUserByCategoryCubit extends Cubit<GetFilterUserByCategoryState> {
  final GetFilterUserByCategoryUseCase categoriesUseCase;
  GetFilterUserByCategoryCubit(this.categoriesUseCase) : super(GetFilterUserByCategoryInitial());
  bool isLoading = false;
Future<void> getGetFilterUserByCategoryId(int id) async {
    changeLoadingView();
    try {
      changeLoadingView();
      Either<Failure, BaseOneResponse> result =
          await categoriesUseCase.call(id);
      emit(
        result.fold(
            (failure) =>
                GetFilterUserByCategoryFailure(errorMessage: failure.message.toString()),
            (resp) => GetFilterUserByCategorySuccerss(response: resp)),
      );
    } catch (e) {
      emit(GetFilterUserByCategoryFailure(errorMessage: e.toString()));
    }
  }


  void changeLoadingView() {
    isLoading = !isLoading;
    emit(GetFilterUserByCategoryLoading(isLoading: isLoading));
  }
}
