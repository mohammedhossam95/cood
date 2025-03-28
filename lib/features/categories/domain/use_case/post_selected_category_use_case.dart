
import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/core/error/failures.dart';
import 'package:cood/core/usecases/usecase.dart';
import 'package:cood/features/categories/domain/repository/categories_repository.dart';
import 'package:dartz/dartz.dart';

class PostSelectedCategoryUseCase extends UseCase<BaseListResponse, List<int>> {
  final CategoriesRepositry categoriesRepository;

  PostSelectedCategoryUseCase({required this.categoriesRepository});
  @override
  Future<Either<Failure, BaseListResponse>> call(List<int> params) async {
    return await categoriesRepository.postSelectedCategory(params);
  }
}
