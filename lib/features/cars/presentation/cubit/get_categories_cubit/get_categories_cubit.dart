import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/usecases/usecase.dart';
import '/features/cars/domain/usecases/get_categories_usecase.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesUsecase getCategoriesUsecase;
  bool isLoading = false;

  GetCategoriesCubit({required this.getCategoriesUsecase})
      : super(GetCategoriesInitial());

  Future<void> getCategories() async {
    changeLoading();
    try {
      final result = await getCategoriesUsecase(NoParams());
      changeLoading();
      emit(
        result.fold(
          (failure) => GetCategoriesError(message: failure.message ?? ""),
          (resp) => GetCategoriesSuccess(response: resp),
        ),
      );
    } catch (e) {
      emit(GetCategoriesError(message: e.toString()));
    }
  }

  void changeLoading() {
    isLoading = !isLoading;
    emit(GetCategoriesLoading(isLoading: isLoading));
  }
}
