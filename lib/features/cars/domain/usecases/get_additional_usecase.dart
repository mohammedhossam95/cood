import 'package:dartz/dartz.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/error/failures.dart';
import '/core/params/car_params.dart';
import '/core/usecases/usecase.dart';
import '/features/cars/domain/repositories/cars_repo.dart';

class GetAdditionalUsecase extends UseCase<BaseListResponse, CarParams> {
  final CarsRepo repository;

  GetAdditionalUsecase({required this.repository});

  @override
  Future<Either<Failure, BaseListResponse>> call(CarParams params) async {
    return await repository.getAdditional(params: params);
  }
}
