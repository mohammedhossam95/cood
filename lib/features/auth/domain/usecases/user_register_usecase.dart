import 'package:cood/core/params/auth_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/user_register_model.dart';
import '../repositories/auth_repo.dart';

class UserRegisterUseCase extends UseCase<UserRegisterRespModel, AuthParams> {
  final AuthRepository repository;

  UserRegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, UserRegisterRespModel>> call(AuthParams params) async {
    return await repository.userRegisterRepo(params: params);
  }
}
