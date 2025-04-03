part of 'add_story_cubit.dart';

sealed class StoryState extends Equatable {
  const StoryState();

  @override
  List<Object> get props => [];
}

final class StoryInitial extends StoryState {}

final class StoryLoading extends StoryState {
  final bool isLoading;

  const StoryLoading({required this.isLoading});
}

final class StorySuccess extends StoryState {
  final BaseOneResponse response;

  const StorySuccess({required this.response});
}

final class StoryFailure extends StoryState {
  final String errorMessage;

  const StoryFailure({required this.errorMessage});
}
