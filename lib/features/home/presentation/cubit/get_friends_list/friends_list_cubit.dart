import 'package:bloc/bloc.dart';
import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/core/error/failures.dart';
import 'package:cood/features/home/domain/usecases/get_friends_list_use_case.dart';
import 'package:cood/features/home/presentation/cubit/get_friends_list/friends_list_state.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecase.dart';


class FriendsListCubit extends Cubit<GetFriendsListState> {
  final GetFriendsListUseCase getFriendsListUseCase;
  FriendsListCubit({required this.getFriendsListUseCase}) : super(GetFriendsListInitial());
  bool isLoading = false;
  void changeLoadingView() {
    isLoading = !isLoading;
    emit(GetFriendsListLoading(isLoading: isLoading));
  }
  //--------------this will call in this function getCurrentTapBarWidget;
  Future<void> getFriendsList() async {
    changeLoadingView();
    try {
      changeLoadingView();
      Either<Failure, BaseListResponse> result =
          await getFriendsListUseCase.call(NoParams());
      emit(
        result.fold(
          (failure) =>
              GetFriendsListFailure(errorMessage: failure.message.toString()),
          (resp) => GetFriendsListSuccerss(response: resp),
        ),
      );
    } catch (e) {
      print('allllllllllll${e.toString()}');
      emit(GetFriendsListFailure(errorMessage: e.toString()));
    }
  }
}
