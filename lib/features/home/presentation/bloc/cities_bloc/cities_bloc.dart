import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/base_classes/pagination.dart';
import '/core/error/failures.dart';
import '/core/params/search_params.dart';
import '/features/cars/domain/entities/car_entity.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../domain/usecases/get_cities_use_case.dart';

part 'cities_event.dart';
part 'cities_state.dart';

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  final GetCitiesUseCase getCitiesUseCase;
  CitiesBloc({required this.getCitiesUseCase}) : super(const CitiesState()) {
    on<CitiesFetched>(
      _onSpecialtiesFetched,
      // transformer: throttleDroppable(throttleDuration),
      transformer: debounce(AppStrings.duration),
    );
  }

  Future<void> _onSpecialtiesFetched(
    CitiesFetched event,
    Emitter<CitiesState> emit,
  ) async {
    if (event.data.keyword!.isNotEmpty) {
      emit(state.copyWith(
        status: CitiesStatus.initial,
        hasReachedMax: false,
      ));
    }
    if (state.hasReachedMax) return;
    try {
      if (state.status == CitiesStatus.initial) {
        Either<Failure, BaseListResponse> response = await getCitiesUseCase(
          SearchParams(
            keyword: event.data.keyword ?? '',
          ),
        );
        return emit(response.fold(
          (failure) => state.copyWith(
            status: CitiesStatus.failure,
            message: '',
          ),
          (resp) => state.copyWith(
            status: CitiesStatus.success,
            posts: resp.data as List<City>,
            pagination: resp.pagination,
            hasReachedMax:
                resp.pagination?.currentPage == resp.pagination?.lastPage,
          ),
        ));
      }
      // final posts = await _fetchSpecialties(state.posts.length);
      Either<Failure, BaseListResponse> response =
          await getCitiesUseCase(event.data);
      return emit(response.fold(
        (failure) => state.copyWith(status: CitiesStatus.failure),
        (resp) => resp.data!.isEmpty
            ? state.copyWith(hasReachedMax: false)
            : state.copyWith(
                status: CitiesStatus.success,
                posts: List.of(state.posts)..addAll(resp.data as List<City>),
              ),
      ));
    } catch (e) {
      emit(state.copyWith(status: CitiesStatus.failure, message: e.toString()));
    }
  }
}
