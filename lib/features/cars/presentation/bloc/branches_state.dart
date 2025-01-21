part of 'branches_bloc.dart';

enum BranchesStatus { initial, success, failure }

final class BranchesState extends Equatable {
  const BranchesState({
    this.status = BranchesStatus.initial,
    this.posts = const <Branch>[],
    this.hasReachedMax = false,
    this.pagination,
    this.message,
  });

  final BranchesStatus status;
  final List<Branch> posts;
  final bool hasReachedMax;
  final Pagination? pagination;
  final String? message;

  BranchesState copyWith({
    BranchesStatus? status,
    List<Branch>? posts,
    bool? hasReachedMax,
    Pagination? pagination,
    String? message,
  }) {
    return BranchesState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      pagination: pagination ?? this.pagination,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return '''
    status: $status, hasReachedMax: $hasReachedMax, data: ${posts.length},
    pagination current: ${pagination?.currentPage}, last: ${pagination?.lastPage},
    message: ${message ?? ''},
    ''';
  }

  @override
  List<Object> get props => [
        status,
        posts,
        hasReachedMax,
        pagination ?? const Pagination(),
        message ?? ''
      ];
}
