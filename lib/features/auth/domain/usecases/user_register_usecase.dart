import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/user_register_model.dart';
import '../repositories/auth_repo.dart';

class UserRegisterUseCase
    extends UseCase<UserRegisterRespModel, UserRegisterParams> {
  final AuthRepository repository;

  UserRegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, UserRegisterRespModel>> call(
      UserRegisterParams params) async {
    return await repository.userRegisterRepo(params: params);
  }
}

class UserRegisterParams extends Equatable {
  final String? firstName;
  final String? mobile;
  final String? password;
  final String? address;
  final String? latitude;
  final String? longitude;
  final String? deviceId;
  final String? deviveType;
  final List<File>? personAvatar;
  final File? avatar;

  const UserRegisterParams({
    this.firstName,
    this.address,
    this.latitude,
    this.longitude,
    this.deviceId,
    this.deviveType,
    this.mobile,
    this.password,
    this.personAvatar,
    this.avatar,
  });
  Map<String, dynamic> toJson() => {
        'name': firstName,
        'phone': mobile,
        'address': address,
        'lat': latitude,
        'lng': longitude,
        'device_id': deviceId,
        'device_type': deviveType,
        'password': password,
        'avatar': avatar,
      };

  @override
  List<Object?> get props => <Object?>[
        firstName,
        mobile,
        password,
        address,
        latitude,
        longitude,
        deviceId,
        deviveType,
        personAvatar,
    avatar,
      ];
}
