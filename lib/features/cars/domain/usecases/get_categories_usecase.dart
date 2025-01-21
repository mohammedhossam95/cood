import 'package:dartz/dartz.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/cars/domain/repositories/cars_repo.dart';

class GetCategoriesUsecase extends UseCase<BaseListResponse, NoParams> {
  final CarsRepo repository;

  GetCategoriesUsecase({required this.repository});

  @override
  Future<Either<Failure, BaseListResponse>> call(NoParams params) async {
    return await repository.getCategories();
  }
}
