import 'package:cood/features/categories/domain/repository/categories_repository.dart';
import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';

import '../../../../core/base_classes/base_list_response.dart';

class CategoriesUseCase extends UseCase<BaseListResponse, NoParams> {
  final CategoriesRepositry categoriesRepository;

  CategoriesUseCase({required this.categoriesRepository});
  @override
  Future<Either<Failure, BaseListResponse>> call(NoParams params) =>
      categoriesRepository.fetchCategories();
}
