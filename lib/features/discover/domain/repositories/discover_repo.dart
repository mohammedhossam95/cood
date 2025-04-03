import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/features/discover/presentation/screens/story_preview_screen.dart';
import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';

abstract class DiscoverRepo {
  Future<Either<Failure, BaseListResponse>> getUserStories();
  Future<Either<Failure, BaseOneResponse>> addStory(PreviewParams params);
}
