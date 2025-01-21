// import 'dart:developer';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:equatable/equatable.dart';
// import 'package:dartz/dartz.dart';

// import '../../../../core/error/failures.dart';
// import '../../../../core/usecases/usecase.dart';
// import '../../../../core/utils/extension.dart';
// import '../entities/update_register_response.dart';
// import '../repositories/auth_repo.dart';


// class UpdateRegisterUseCase extends UseCase<UpdateRegisterResponse, UpdateRegisterParams> {
//   final AuthRepository repository;

//   UpdateRegisterUseCase({required this.repository});

//   @override
//   Future<Either<Failure, UpdateRegisterResponse>> call(UpdateRegisterParams params) async {
//     return await repository.updateRegister(params: params);
//   }
// }


// class UpdateRegisterParams extends Equatable {
//   final String firstName;
//   // final String middleAndLastName;
//   final String dob;
//   final String gender;
//   final int? specialityId;
//   final int? subSpecialityId;
//   final int? titleId;
//   final int? cityId;
//   final File? doctorPhoto;
//   final File? certificatePhoto;
//   final String nationalNumber;
//   final List<File> nationalNumberImages;

//   const UpdateRegisterParams({
//     required this.firstName,
//     // required this.middleAndLastName,
//     required this.dob,
//     required this.gender,
//     this.cityId,
//     required this.specialityId,
//     this.subSpecialityId,
//     this.titleId,
//     this.doctorPhoto,
//     required this.certificatePhoto,
//     required this.nationalNumber,
//     required this.nationalNumberImages,
//   });

//   Future<FormData> toJson() async{
//     final FormData formData = FormData.fromMap({
//       'first_name': firstName,
//       // 'last_name': middleAndLastName,
//       'dob': dob,
//       'gender': gender,
//       'city_id': cityId,
//       'doctor[speciality_id]': specialityId,
//       'doctor[sub_speciality_id]': subSpecialityId,
//       'doctor[title_id]': titleId,
//       'national_number': nationalNumber,
//     });
//     if(certificatePhoto != null){
//       formData.files.add(MapEntry('doctor[attachments][practice_cert][0]', await MultipartFile.fromFile(
//         certificatePhoto!.path,
//         filename: certificatePhoto!.path.split('/').last,
//       )));
//     }
//     if(doctorPhoto != null){
//       formData.files.add(MapEntry('photo', await MultipartFile.fromFile(
//         doctorPhoto!.path,
//         filename: doctorPhoto!.path.split('/').last,
//       )));
//     }

//     int i = 0;
//     for(final item in nationalNumberImages){
//       formData.files.add(MapEntry('doctor[attachments][national_id][$i]', await MultipartFile.fromFile(
//         item.path,
//         filename: item.path.split('/').last,
//       )));
//       i++;
//     }

//     log('UpdateRegisterParams: ${formData.toPrint}');

//     return formData;

//   }

//   @override
//   List<Object?> get props => <Object?>[
//     firstName,
//     // middleAndLastName,
//     dob,
//     gender,
//     cityId,
//     specialityId,
//     subSpecialityId,
//     titleId,
//     nationalNumber,
//     nationalNumberImages,
//   ];
// }



