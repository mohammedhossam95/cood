import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/params/car_params.dart';
import '/features/cars/domain/usecases/get_agents_usecase.dart';

part 'get_agents_state.dart';

class GetAgentsCubit extends Cubit<GetAgentsState> {
  final GetAgentsUseCase getAgentsUseCase;
  bool isLoading = false;
  GetAgentsCubit({required this.getAgentsUseCase}) : super(GetAgentsInitial());

  Future<void> getAgents({required CarParams params}) async {
    changeLoading();
    try {
      final result = await getAgentsUseCase(params);
      changeLoading();
      emit(
        result.fold(
          (failure) => GetAgentsError(message: failure.message ?? ""),
          (resp) => GetAgentsSuccess(response: resp),
        ),
      );
    } catch (e) {
      emit(GetAgentsError(message: e.toString()));
    }
  }

  void changeLoading() {
    isLoading = !isLoading;
    emit(GetAgentsLoading(isLoading: isLoading));
  }
}
