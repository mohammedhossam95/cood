import 'package:cood/features/categories/domain/repository/categories_repository.dart';
import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';

import '../../../../core/base_classes/base_list_response.dart';

class GetAdditionalUseCase extends UseCase<BaseListResponse, int> {
  final CategoriesRepositry categoriesRepository;

  GetAdditionalUseCase({required this.categoriesRepository});
  @override
  Future<Either<Failure, BaseListResponse>> call(int params) =>
      categoriesRepository.getAdditional(params);
}
