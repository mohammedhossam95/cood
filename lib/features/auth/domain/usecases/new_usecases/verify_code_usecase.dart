import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/auth/data/models/new_models/verify_code_model.dart';
import '/features/auth/domain/repositories/auth_repo.dart';

class VerifyCodeUsecase
    extends UseCase<VerifyCodeResponseModel, VerifyCodeParams> {
  final AuthRepository repository;

  VerifyCodeUsecase({required this.repository});

  @override
  Future<Either<Failure, VerifyCodeResponseModel>> call(
          VerifyCodeParams params) async =>
      await repository.verifyCode(params: params);
}

class VerifyCodeParams {
  final String? userCode;
  final String? otp;

  VerifyCodeParams({
    this.userCode,
    this.otp,
  });
  Map<String, dynamic> toJson() => {
        "userCode": userCode,
        "otp": otp,
      };
}
