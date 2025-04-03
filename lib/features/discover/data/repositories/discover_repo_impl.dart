import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/core/error/exceptions.dart';
import 'package:cood/features/discover/data/datasources/discover_remote_data_source.dart';
import 'package:cood/features/discover/domain/repositories/discover_repo.dart';
import 'package:cood/features/discover/presentation/screens/story_preview_screen.dart';
import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';

class DiscoverRepoImpl implements DiscoverRepo {
  final DiscoverRemoteDataSource remote;
  DiscoverRepoImpl({required this.remote});

  @override
  Future<Either<Failure, BaseListResponse>> getUserStories() async {
    try {
      final remoteData = await remote.getRemoteStories();
      return Right(remoteData);
    } on ServerException catch (error) {
      return Left(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> addStory(
      PreviewParams params) async {
    try {
      final remoteData = await remote.addRemoteStory(params);
      return Right(remoteData);
    } on ServerException catch (error) {
      return Left(error.toFailure());
    }
  }
}
