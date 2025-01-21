part of 'cities_bloc.dart';

sealed class CitiesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class CitiesFetched extends CitiesEvent {
  final SearchParams data;
  CitiesFetched(this.data);
}
