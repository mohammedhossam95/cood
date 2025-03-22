import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/core/params/auth_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repo.dart';

class VerifyOtpUseCase extends UseCase<BaseOneResponse, AuthParams> {
  final AuthRepository repository;

  VerifyOtpUseCase({required this.repository});

  @override
  Future<Either<Failure, BaseOneResponse>> call(AuthParams params) async {
    return await repository.verifyOtpRpo(params: params);
  }
}
