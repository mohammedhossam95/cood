import 'package:cood/core/params/auth_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/confirm_reset_password_response.dart';
import '../repositories/auth_repo.dart';

class ConfirmResetPasswordUseCase
    extends UseCase<ConfirmResetPasswordResponse, AuthParams> {
  final AuthRepository repository;

  ConfirmResetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, ConfirmResetPasswordResponse>> call(
      AuthParams params) async {
    return await repository.confirmResetPassword(params: params);
  }
}
