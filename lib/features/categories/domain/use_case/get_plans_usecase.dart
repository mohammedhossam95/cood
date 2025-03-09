import 'package:cood/features/categories/domain/repository/categories_repository.dart';
import 'package:dartz/dartz.dart';
import '/core/base_classes/base_one_response.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';

class GetPlansUseCase extends UseCase<BaseOneResponse, NoParams> {
  final CategoriesRepositry categoriesRepository;

  GetPlansUseCase({required this.categoriesRepository});
  @override
  Future<Either<Failure, BaseOneResponse>> call(NoParams params) =>
      categoriesRepository.getPlans();
}
