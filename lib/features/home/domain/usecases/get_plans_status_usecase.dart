import 'package:dartz/dartz.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/home/domain/repositories/home_repo.dart';

class GetPlansStatusUsecase extends UseCase<BaseOneResponse, NoParams> {
  final HomeRepo repository;

  GetPlansStatusUsecase({required this.repository});

  @override
  Future<Either<Failure, BaseOneResponse>> call(NoParams params) async {
    return await repository.getPlanStatus();
  }
}
