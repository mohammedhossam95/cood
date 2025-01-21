import 'package:dartz/dartz.dart';

import '/core/base_classes/base_one_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repo.dart';

class LogoutUseCase extends UseCase<BaseOneResponse, LogOutParams> {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  @override
  Future<Either<Failure, BaseOneResponse>> call(params) async {
    return await repository.logout(params: params);
  }
}

class LogOutParams {
  final String? deviceId;
  final String? deviceType;

  LogOutParams({
    this.deviceId,
    this.deviceType,
  });
  Map<String, dynamic> toJson() => {
        'device_id': deviceId,
        'device_type': deviceType,
      };
}
