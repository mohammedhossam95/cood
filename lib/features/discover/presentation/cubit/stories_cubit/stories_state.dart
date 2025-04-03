part of 'stories_cubit.dart';

sealed class StoriesState extends Equatable {
  const StoriesState();

  @override
  List<Object> get props => [];
}

final class StoriesInitial extends StoriesState {}

final class StoriesLoading extends StoriesState {
  final bool isLoading;

  const StoriesLoading({required this.isLoading});
}

final class StoriesSuccess extends StoriesState {
  final BaseListResponse response;

  const StoriesSuccess({required this.response});
}

final class StoriesFailure extends StoriesState {
  final String errorMessage;

  const StoriesFailure({required this.errorMessage});
}
