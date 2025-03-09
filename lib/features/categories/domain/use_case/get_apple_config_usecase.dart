import 'package:cood/features/categories/domain/entity/checkout_response.dart';
import 'package:cood/features/categories/domain/repository/categories_repository.dart';
import 'package:dartz/dartz.dart';

import '/core/params/car_params.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetAppleConfigUseCase extends UseCase<CheckoutResponse, CarParams> {
  final CategoriesRepositry categoriesRepositry;

  GetAppleConfigUseCase({required this.categoriesRepositry});

  @override
  Future<Either<Failure, CheckoutResponse>> call(CarParams params) =>
      categoriesRepositry.getConfig(params);
}
