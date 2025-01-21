import 'dart:io';

import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/auth/data/models/new_models/register_model.dart';
import '/features/auth/domain/repositories/auth_repo.dart';

class RegisterUseCase extends UseCase<RegisterResponseModel, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});
  @override
  Future<Either<Failure, RegisterResponseModel>> call(
          RegisterParams params) async =>
      await authRepository.registerRepo(params: params);
}

class RegisterParams {
  final String? userCode;
  final String? username;
  final String? email;
  final String? password;
  final File? identification;
  final File? drivingLicence;

  RegisterParams({
    this.username,
    this.email,
    this.password,
    this.identification,
    this.drivingLicence,
    this.userCode,
  });
  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "identification": identification,
        "drivingLicence": drivingLicence,
        "userCode": userCode,
      };
}
