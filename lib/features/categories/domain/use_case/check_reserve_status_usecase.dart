import 'package:cood/features/categories/domain/repository/categories_repository.dart';
import 'package:dartz/dartz.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/params/car_params.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class CheckReserveUseCase extends UseCase<BaseOneResponse, CarParams> {
  final CategoriesRepositry categoriesRepositry;

  CheckReserveUseCase({required this.categoriesRepositry});

  @override
  Future<Either<Failure, BaseOneResponse>> call(CarParams params) =>
      categoriesRepositry.checkReserveStatus(params);
}
