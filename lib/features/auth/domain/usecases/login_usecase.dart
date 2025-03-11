import 'package:cood/core/params/auth_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/login_model.dart';
import '../repositories/auth_repo.dart';

class LoginEmailUseCase extends UseCase<LoginRespModel, AuthParams> {
  final AuthRepository repository;

  LoginEmailUseCase({required this.repository});

  @override
  Future<Either<Failure, LoginRespModel>> call(AuthParams params) async =>
      await repository.loginRepo(params: params);
}
