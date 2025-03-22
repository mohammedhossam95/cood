import 'package:dartz/dartz.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/error/exceptions.dart';
import '/core/error/failures.dart';
import '/core/utils/log_utils.dart';
import '/features/profile/data/datasources/profile_remote_data_source.dart';
import '/features/profile/domain/repositories/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource remote;
  ProfileRepoImpl({required this.remote});

  @override
  Future<Either<Failure, BaseOneResponse>> getUser() async {
    try {
      final BaseOneResponse response = await remote.getUser();
      return Right(response);
    } on AppException catch (error) {
      Log.e(
          '[getUser] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left(error.toFailure());
    }
  }
}
