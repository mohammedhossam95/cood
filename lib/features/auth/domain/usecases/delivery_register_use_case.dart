import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '/core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/delivery_register_model.dart';
import '../repositories/auth_repo.dart';

class DeliveryRegisterUseCase
    extends UseCase<DeliveryRegisterRespModel, DeliveryRegisterParams> {
  final AuthRepository authRepository;

  DeliveryRegisterUseCase({required this.authRepository});
  @override
  Future<Either<Failure, DeliveryRegisterRespModel>> call(
          DeliveryRegisterParams params) async =>
      await authRepository.deliveryRegisterRepo(params: params);
}

class DeliveryRegisterParams extends Equatable {
  final String? name;
  final String? phone;
  final File? avatar;
  final String? address;
  final String? latitude;
  final String? longitude;
  final String? carNumber;
  final File? drivingLicense;
  final File? idNumber;
  final String? deviceId;
  final String? deviceType;
  final String? password;

  const DeliveryRegisterParams({
    this.name,
    this.phone,
    this.avatar,
    this.address,
    this.latitude,
    this.longitude,
    this.carNumber,
    this.drivingLicense,
    this.idNumber,
    this.deviceId,
    this.deviceType,
    this.password,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'avatar': avatar,
        'address': address,
        'lat': latitude,
        'lng': longitude,
        'car_number': carNumber,
        'driving_license': drivingLicense,
        'id_number': idNumber,
        'device_id': deviceId,
        'device_type': deviceType,
        'password': password,
      };
  @override
  List<Object?> get props => [
        name,
        phone,
        avatar,
        address,
        latitude,
        longitude,
        carNumber,
        drivingLicense,
        idNumber,
        deviceId,
        deviceType,
        password,
      ];
}
