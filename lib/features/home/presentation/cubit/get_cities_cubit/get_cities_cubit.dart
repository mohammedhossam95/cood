import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/core/params/search_params.dart';
import '/features/home/domain/usecases/get_cities_use_case.dart';
import '../../../../../core/base_classes/base_list_response.dart';

part 'get_cities_state.dart';

class GetCitiesCubit extends Cubit<GetCitiesState> {
  GetCitiesUseCase getCitiesUsecase;
  bool isLoading = false;
  GetCitiesCubit({required this.getCitiesUsecase}) : super(GetCitiesInitial());

  Future<void> getCities() async {
    changeLoading();
    try {
      final result = await getCitiesUsecase(SearchParams());
      changeLoading();
      emit(
        result.fold(
          (failure) => GetCitiesError(message: failure.message ?? ""),
          (resp) => GetCitiesSuccess(response: resp),
        ),
      );
    } catch (e) {
      emit(GetCitiesError(message: e.toString()));
    }
  }

  void changeLoading() {
    isLoading = !isLoading;
    emit(GetCitiesLoading(isLoading: isLoading));
  }
}
