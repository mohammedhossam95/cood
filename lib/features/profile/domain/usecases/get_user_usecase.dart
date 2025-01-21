import 'package:dartz/dartz.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/profile/domain/repositories/profile_repo.dart';

class GetUserUsecase extends UseCase<BaseOneResponse, NoParams> {
  final ProfileRepo repository;

  GetUserUsecase({required this.repository});

  @override
  Future<Either<Failure, BaseOneResponse>> call(NoParams params) async {
    return await repository.getUser();
  }
}
