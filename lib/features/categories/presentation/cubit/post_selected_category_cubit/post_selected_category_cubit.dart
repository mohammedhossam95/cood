

import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/core/error/failures.dart';
import 'package:cood/features/categories/domain/use_case/post_selected_category_use_case.dart';
import 'package:cood/features/categories/presentation/cubit/post_selected_category_cubit/post_selected_category_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostSelectedCategoryCubit extends Cubit<PostSelectedCategoryState> {
  final PostSelectedCategoryUseCase categoriesUseCase;

  PostSelectedCategoryCubit(this.categoriesUseCase) : super(PostSelectedCategoryInitial());

  bool isLoading = false;

  Future<void> postSelectedCategory(List<int>ids) async {
    changeLoadingView();
    try {
      Either<Failure, BaseListResponse> result =
          await categoriesUseCase.call(ids);
      emit(
        result.fold(
            (failure) =>
                PostSelectedCategoryFailure(errorMessage: failure.message.toString()),
            (resp) => PostSelectedCategorySuccerss(response: resp)),
      );
    } catch (e) {
      emit(PostSelectedCategoryFailure(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(PostSelectedCategoryLoading(isLoading: isLoading));
  }
    void emitInitial() {
    emit(PostSelectedCategoryInitial());
  }
}
