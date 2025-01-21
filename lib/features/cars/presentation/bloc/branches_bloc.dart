import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/base_classes/pagination.dart';
import '/core/error/failures.dart';
import '/core/params/car_params.dart';
import '/features/cars/domain/entities/branch_entity.dart';
import '/features/cars/domain/usecases/get_branches_usecase.dart';
import '../../../../../core/utils/app_strings.dart';

part 'branches_event.dart';
part 'branches_state.dart';

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class BranchesBloc extends Bloc<BranchesEvent, BranchesState> {
  final GetBranchesUsecase getBranchesUseCase;

  BranchesBloc({required this.getBranchesUseCase})
      : super(const BranchesState()) {
    on<BranchesFetched>(
      _onBranchesFetched,
      transformer: debounce(AppStrings.duration),
    );
  }

  Future<void> _onBranchesFetched(
    BranchesFetched event,
    Emitter<BranchesState> emit,
  ) async {
    if (event.data.customerId != null || event.data.cats != null) {
      emit(state.copyWith(
        status: BranchesStatus.initial,
        hasReachedMax: false,
      ));
    }
    if (state.hasReachedMax) return;
    try {
      if (state.status == BranchesStatus.initial) {
        Either<Failure, BaseListResponse> response = await getBranchesUseCase(
          event.data,
        );
        return emit(response.fold(
          (failure) => state.copyWith(
            status: BranchesStatus.failure,
            message: '',
          ),
          (resp) => state.copyWith(
            status: BranchesStatus.success,
            posts: resp.data as List<Branch>,
            pagination: resp.pagination,
            hasReachedMax:
                resp.pagination?.currentPage == resp.pagination?.lastPage,
          ),
        ));
      }

      Either<Failure, BaseListResponse> response =
          await getBranchesUseCase(event.data);
      return emit(response.fold(
        (failure) => state.copyWith(status: BranchesStatus.failure),
        (resp) => resp.data!.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: BranchesStatus.success,
                posts: List.of(state.posts)..addAll(resp.data as List<Branch>),
              ),
      ));
    } catch (e) {
      emit(state.copyWith(
          status: BranchesStatus.failure, message: e.toString()));
    }
  }
}
