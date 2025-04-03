import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/features/discover/domain/repositories/discover_repo.dart';
import 'package:cood/features/discover/presentation/screens/story_preview_screen.dart';
import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';

class AddStoryUseCase extends UseCase<BaseOneResponse, PreviewParams> {
  final DiscoverRepo discoverRepo;

  AddStoryUseCase({required this.discoverRepo});
  @override
  Future<Either<Failure, BaseOneResponse>> call(PreviewParams params) =>
      discoverRepo.addStory(params);
}
