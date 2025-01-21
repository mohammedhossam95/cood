// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../core/error/failures.dart';
// import '../../../../../core/utils/values/strings.dart';
// import '../../../domain/usecases/verify_email_usecase.dart';
// import '../../../domain/entities/verify_email_response.dart';

// part 'verify_email_states.dart';

// class VerifyEmailCubit extends Cubit<VerifyEmailState> {
//   final VerifyEmailUseCase verifyEmailUseCase;

//   VerifyEmailCubit(this.verifyEmailUseCase) : super(const VerifyEmailInitialState());

//   VerifyEmailData? data;
//   String? email;

//   Future<void> fVerifyEmail({
//    required String email,
//    required String code,
//   }) async {
//     emit(const VerifyEmailLoadingState());
//     final Either<Failure, VerifyEmailResponse> eitherResult = await verifyEmailUseCase(VerifyEmailParams(
//       email: email,
//       code: code,
//     ));
//     eitherResult.fold((Failure failure) {
//       emit(VerifyEmailErrorState(message: failure.message?? Strings.pleaseTryAgainLater));
//     }, (VerifyEmailResponse response) {
//       data = response.data;
//       emit(VerifyEmailSuccessState(value: response.data));
//     });
//   }

//   void setEmail(String email) {
//     this.email = email;
//     emit(const VerifyEmailInitialState());
//   }
// }

