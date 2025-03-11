import 'package:cood/features/categories/domain/entity/checkout_response.dart';
import 'package:dartz/dartz.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/params/car_params.dart';
import '../../../../core/base_classes/base_list_response.dart';
import '../../../../core/error/failures.dart';

abstract class CategoriesRepositry {
  Future<Either<Failure, BaseListResponse>> fetchCategories();
  Future<Either<Failure, BaseOneResponse>> checkReserveStatus(CarParams params);
  Future<Either<Failure, BaseOneResponse>> reserve(CarParams params);
  Future<Either<Failure, CheckoutResponse>> getConfig(CarParams params);
  Future<Either<Failure, BaseOneResponse>> getPriceStatus(CarParams params);
  Future<Either<Failure, BaseOneResponse>> completeAPay(CarParams params);
  Future<Either<Failure, BaseListResponse>> getAdditional(int categoryId);
}
