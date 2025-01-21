import 'package:bloc/bloc.dart';

import '/core/usecases/usecase.dart';
import '/features/cars/domain/usecases/get_brands_usecase.dart';
import '/features/cars/presentation/cubit/get_brands_cubit/get_brands_state.dart';

class GetBrandsCubit extends Cubit<GetBrandsState> {
  GetBrandsUsecase getBrandsUsecase;
  bool isLoading = false;

  GetBrandsCubit({required this.getBrandsUsecase}) : super(GetBrandsInitial());

  Future<void> getBrands() async {
    changeLoading();
    try {
      final result = await getBrandsUsecase(NoParams());
      changeLoading();
      emit(
        result.fold(
          (failure) => GetBrandsError(message: failure.message ?? ""),
          (resp) => GetBrandsSuccess(response: resp),
        ),
      );
    } catch (e) {
      emit(GetBrandsError(message: e.toString()));
    }
  }

  void changeLoading() {
    isLoading = !isLoading;
    emit(GetBrandsLoading(isLoading: isLoading));
  }
}
