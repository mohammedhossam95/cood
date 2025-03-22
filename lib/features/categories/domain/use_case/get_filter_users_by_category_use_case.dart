import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/core/error/failures.dart';
import 'package:cood/core/usecases/usecase.dart';
import 'package:cood/features/categories/domain/repository/categories_repository.dart';
import 'package:dartz/dartz.dart';

class GetFilterUserByCategoryUseCase extends UseCase<BaseOneResponse, int> {
  final CategoriesRepositry repository;
  GetFilterUserByCategoryUseCase(this.repository);
  @override
  Future<Either<Failure, BaseOneResponse>> call(int params)async {
    return await repository.getFilterUserByCategory(params);
  }
}
