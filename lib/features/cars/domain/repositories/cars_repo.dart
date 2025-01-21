import 'package:dartz/dartz.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/error/failures.dart';
import '/core/params/car_params.dart';

abstract class CarsRepo {
  Future<Either<Failure, BaseListResponse>> getCars(
      {required CarParams params});
  Future<Either<Failure, BaseListResponse>> getAgents(
      {required CarParams params});
  Future<Either<Failure, BaseListResponse>> getAdditional(
      {required CarParams params});
  Future<Either<Failure, BaseListResponse>> getFreeAdditional(
      {required CarParams params});
  Future<Either<Failure, BaseListResponse>> getBrands();
  Future<Either<Failure, BaseListResponse>> getCategories();
  Future<Either<Failure, BaseListResponse>> getBranches(CarParams params);
}
