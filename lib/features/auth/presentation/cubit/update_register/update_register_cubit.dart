// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../core/error/failures.dart';
// import '../../../../../core/utils/values/strings.dart';
// import '../../../../profile/domain/entities/get_profile_response.dart';
// import '../../../domain/usecases/update_register_usecase.dart';
// import '../../../domain/entities/update_register_response.dart';

// part 'update_register_states.dart';

// class UpdateRegisterCubit extends Cubit<UpdateRegisterState> {
//   final UpdateRegisterUseCase updateRegisterUseCase;

//   UpdateRegisterCubit(this.updateRegisterUseCase) : super(const UpdateRegisterInitialState());

//   // User? data;
//   File? doctorPhoto;
//   File? certificatePhoto;
//   List<File> nationalNumberImages = [];

//   Future<void> fUpdateRegister({
//     required String firstName,
//     // required String middleAndLastName,
//     required String dob,
//     required String gender,
//     required int specialityId,
//     int? subSpecialityId,
//     int? titleId,
//     int? cityId,
//     required String nationalNumber,
//   }) async {
//     emit(const UpdateRegisterLoadingState());
//     final Either<Failure, UpdateRegisterResponse> eitherResult = await updateRegisterUseCase(UpdateRegisterParams(
//       firstName: firstName,
//       // middleAndLastName: middleAndLastName,
//       dob: dob,
//       gender: gender,
//       cityId: cityId,
//       specialityId: specialityId,
//       subSpecialityId: subSpecialityId,
//       titleId: titleId,
//       certificatePhoto: certificatePhoto,
//       doctorPhoto: doctorPhoto,
//       nationalNumber: nationalNumber,
//       nationalNumberImages: nationalNumberImages,
//     ));
//     eitherResult.fold((Failure failure) {
//       emit(UpdateRegisterErrorState(
//         message: failure.message?? Strings.pleaseTryAgainLater,
//         isUpdateRegisterApprovedUserFailure: failure is UpdateRegisterApprovedUserFailure,
//       ));
//     }, (UpdateRegisterResponse response) {
//       data = response.data;
//       emit(UpdateRegisterSuccessState(
//         value: response.data,
//         message: response.message,
//       ));
//     });
//   }
//   void setN(){
//     emit(const UpdateRegisterInitialState());
//   }

//   void setDoctorPhoto(File photo){
//     doctorPhoto = photo;
//     emit(const UpdateRegisterLoadingState());
//     emit(const UpdateRegisterInitialState());
//   }

//   void setNationalNumberImages(List<File> values){
//     nationalNumberImages = values;
//     emit(const UpdateRegisterLoadingState());
//     emit(const UpdateRegisterInitialState());
//   }

//   void setCertificatePhoto(File photo){
//     certificatePhoto = photo;
//     emit(const UpdateRegisterLoadingState());
//     emit(const UpdateRegisterInitialState());
//   }

//   void resetFields(){
//     data = null;
//     doctorPhoto = null;
//     certificatePhoto = null;
//     nationalNumberImages = [];
//   }
// }

