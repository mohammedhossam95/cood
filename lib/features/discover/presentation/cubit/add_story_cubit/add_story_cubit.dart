import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/features/discover/domain/usecases/add_story_use_case.dart';
import 'package:cood/features/discover/presentation/screens/story_preview_screen.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/error/failures.dart';

part 'add_story_state.dart';

class AddStoryCubit extends Cubit<StoryState> {
  final AddStoryUseCase addStoryUseCase;

  AddStoryCubit(this.addStoryUseCase) : super(StoryInitial());

  bool isLoading = false;

  Future<void> addStory(PreviewParams params) async {
    changeLoadingView();
    try {
      Either<Failure, BaseOneResponse> result = await addStoryUseCase(params);
      changeLoadingView();

      emit(
        result.fold(
            (failure) => StoryFailure(errorMessage: failure.message.toString()),
            (resp) => StorySuccess(response: resp)),
      );
    } catch (e) {
      emit(StoryFailure(errorMessage: e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(StoryLoading(isLoading: isLoading));
  }
}
