import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/error/failures/i_failure.dart';
import '../../data/models/awesome_place_model.dart';
import '../../data/models/prediction_model.dart';
import '../../domain/usecases/use_case.dart';

part 'awesome_places_search_event.dart';
part 'awesome_places_search_state.dart';

///[AwesomePlacesSearchBloc]
///
class AwesomePlacesSearchBloc
    extends Bloc<AwesomePlacesSearchEvent, AwesomePlacesSearchState> {
  final GetPlacesUseCase useCase;
  final GetLatLngUseCase latLngUseCase;
  final String key;

  AwesomePlacesSearchBloc({
    required this.useCase,
    required this.latLngUseCase,
    required this.key,
  }) : super(AwesomePlacesSearchInitialState()) {
    // Search places when triggered Loading event
    on<AwesomePlacesSearchLoadingEvent>((event, emit) async {
      emit(AwesomePlacesSearchLoadingState(value: event.value));
      final param = ParamSearchModel(value: event.value, key: key);
      final result = await useCase(param: param);
      result.fold((left) {
        if (left is KeyEmptyFailure) {
          emit(AwesomePlacesSearchKeyEmptyState(
              message: "Please enter a valid key"));
        }
        if (left is ServerFailure) {
          emit(AwesomePlacesSearchErrorState());
        }
      }, (right) {
        final res = right as AwesomePlacesSearchModel;
        log(res.predictions!.length.toString());
        add(AwesomePlacesSearchLoadedEvent(places: res));
      });
    });

    on<AwesomePlacesSearchLoadedEvent>((event, emit) =>
        emit(AwesomePlacesSearchLoadedState(places: event.places)));

    on<AwesomePlacesSearchClickedEvent>((event, emit) async {
      final result = await latLngUseCase(param: event.place.placeId!);
      result.fold((left) {
        if (left is ServerFailure) {
          emit(AwesomePlacesSearchErrorState());
        }
      }, (right) {
        event.place.latitude = right.lat;
        event.place.longitude = right.lng;
        emit(AwesomePlacesSearchClickedState(
          place: event.place,
          places: event.places,
        ));
      });
    });
  }

  ///[checkIfContains]
  bool checkIfContains(List<String> types, List<String> data) {
    return types
        .where((type) => data.where((current) => type == current).isNotEmpty)
        .isNotEmpty;
  }
}
