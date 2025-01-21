import 'package:dartz/dartz.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/error/failures.dart';
import '/core/params/search_params.dart';
import '/core/usecases/usecase.dart';
import '/features/home/domain/repositories/home_repo.dart';

class GetCitiesUseCase extends UseCase<BaseListResponse, SearchParams> {
  final HomeRepo repository;

  GetCitiesUseCase({required this.repository});

  @override
  Future<Either<Failure, BaseListResponse>> call(SearchParams params) async {
    return await repository.getCities(params);
  }
}
