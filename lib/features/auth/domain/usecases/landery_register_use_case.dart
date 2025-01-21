import 'dart:io';

import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '../../../../core/base_classes/base_one_response.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repo.dart';

class LanderyRegisterUseCase
    extends UseCase<BaseOneResponse, LanderyRegisterParams> {
  final AuthRepository authRepository;

  LanderyRegisterUseCase({required this.authRepository});
  @override
  Future<Either<Failure, BaseOneResponse>> call(
          LanderyRegisterParams params) async =>
      await authRepository.landeryRegisterRepo(params: params);
}

class LanderyRegisterParams {
  final String? userName;
  final String? phone;
  final String? email;
  final String? address;
  final String? latitude;
  final String? longitude;
  final String? commerical;
  final String? descreptionAR;
  final String? descreptionEN;
  final String? timeFrom;
  final String? timeTo;
  final String? daysWork;
  final String? deviceId;
  final String? deviceType;
  final File? file;

  LanderyRegisterParams({
    this.userName,
    this.phone,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
    this.commerical,
    this.descreptionAR,
    this.descreptionEN,
    this.timeFrom,
    this.timeTo,
    this.daysWork,
    this.deviceId,
    this.deviceType,
    this.file,
  });
  Map<String, dynamic> toJson() => {
        "name": userName,
        "phone": phone,
        "email": email,
        "address": address,
        "lat": latitude,
        "lng": longitude,
        "commercial": commerical,
        "desc_ar": descreptionAR,
        "desc_en": descreptionEN,
        "time_from": timeFrom,
        "time_to": timeTo,
        "days": daysWork,
        "device_id": deviceId,
        "device_type": deviceType,
        "file": file,
      };
}
