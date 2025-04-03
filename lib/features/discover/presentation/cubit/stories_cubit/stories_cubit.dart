import 'package:cood/features/discover/domain/usecases/get_stories_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';

part 'stories_state.dart';

class StoriesCubit extends Cubit<StoriesState> {
  final GetStoriesUseCase getStoriesUseCase;

  StoriesCubit(this.getStoriesUseCase) : super(StoriesInitial());

  bool isLoading = false;

  Future<void> getStoriess() async {
    changeLoadingView();
    try {
      Either<Failure, BaseListResponse> result =
          await getStoriesUseCase(NoParams());
      changeLoadingView();

      emit(
        result.fold(
            (failure) =>
                StoriesFailure(errorMessage: failure.message.toString()),
            (resp) => StoriesSuccess(response: resp)),
      );
    } catch (e) {
      emit(StoriesFailure(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(StoriesLoading(isLoading: isLoading));
  }
}
