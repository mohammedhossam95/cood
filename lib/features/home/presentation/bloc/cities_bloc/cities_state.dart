part of 'cities_bloc.dart';

enum CitiesStatus { initial, success, failure }

final class CitiesState extends Equatable {
  const CitiesState({
    this.status = CitiesStatus.initial,
    this.posts = const <City>[],
    this.hasReachedMax = false,
    this.pagination,
    this.message,
  });

  final CitiesStatus status;
  final List<City> posts;
  final bool hasReachedMax;
  final Pagination? pagination;
  final String? message;

  CitiesState copyWith({
    CitiesStatus? status,
    List<City>? posts,
    bool? hasReachedMax,
    Pagination? pagination,
    String? message,
  }) {
    return CitiesState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      message: message ?? this.message,
      pagination: pagination ?? this.pagination,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''
    status: $status, hasReachedMax: $hasReachedMax, data: ${posts.length},
    pagination current : ${pagination?.currentPage}, last : ${pagination?.lastPage},
    message : ${message.toString()},
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
