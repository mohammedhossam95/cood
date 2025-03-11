import 'package:cood/features/categories/domain/use_case/categories_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesUseCase categoriesUseCase;

  CategoriesCubit(this.categoriesUseCase) : super(CategoriesInitial());

  bool isLoading = false;

  Future<void> getCategoriess() async {
    changeLoadingView();
    try {
      changeLoadingView();
      Either<Failure, BaseListResponse> result =
          await categoriesUseCase.call(NoParams());
      emit(
        result.fold(
            (failure) =>
                CategoriesFailure(errorMessage: failure.message.toString()),
            (resp) => CategoriesSuccerss(response: resp)),
      );
    } catch (e) {
      emit(CategoriesFailure(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(CategoriesLoading(isLoading: isLoading));
  }
}
