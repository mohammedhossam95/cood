import 'package:cood/features/discover/domain/repositories/discover_repo.dart';
import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '../../../../core/base_classes/base_list_response.dart';

class GetStoriesUseCase extends UseCase<BaseListResponse, NoParams> {
  final DiscoverRepo discoverRepo;

  GetStoriesUseCase({required this.discoverRepo});
  @override
  Future<Either<Failure, BaseListResponse>> call(NoParams params) =>
      discoverRepo.getUserStories();
}
