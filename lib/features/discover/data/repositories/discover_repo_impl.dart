import 'package:cood/features/discover/data/datasources/discover_remote_data_source.dart';
import 'package:cood/features/discover/domain/repositories/discover_repo.dart';
import 'package:dartz/dartz.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/error/failures.dart';

class DiscoverRepoImpl implements DiscoverRepo {
  final DiscoverRemoteDataSource remote;
  DiscoverRepoImpl({required this.remote});

  @override
  Future<Either<Failure, BaseOneResponse>> getUserStories() {
    throw UnimplementedError();
  }
}
