// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../core/error/failures.dart';
// import '../../../../../core/utils/values/strings.dart';
// import '../../../domain/usecases/check_mobile_usecase.dart';
// import '../../../domain/entities/check_mobile_response.dart';

// part 'check_mobile_states.dart';

// class CheckMobileCubit extends Cubit<CheckMobileState> {
//   final CheckMobileUseCase checkMobileUseCase;

//   CheckMobileCubit(this.checkMobileUseCase) : super(const CheckMobileInitialState());

//   CheckMobileData? data;

//   Future<void> fCheckMobile({
//    required String mobile,
//    required String callingCode,
//   }) async {
//     emit(const CheckMobileLoadingState());
//     final Either<Failure, CheckMobileResponse> eitherResult = await checkMobileUseCase(CheckMobileParams(
//       mobile: mobile,
//       callingCode: callingCode,
//     ));
//     eitherResult.fold((Failure failure) {
//       emit(CheckMobileErrorState(message: failure.message?? Strings.pleaseTryAgainLater));
//     }, (CheckMobileResponse response) {
//       data = response.data;
//       emit(CheckMobileSuccessState(value: response.data));
//     });
//   }
// }

