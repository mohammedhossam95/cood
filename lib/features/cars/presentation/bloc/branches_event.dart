part of 'branches_bloc.dart';

sealed class BranchesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class BranchesFetched extends BranchesEvent {
  final CarParams data;
  BranchesFetched(this.data);
}
