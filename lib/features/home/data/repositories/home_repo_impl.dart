import 'package:dartz/dartz.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/error/exceptions.dart';
import '/core/error/failures.dart';
import '/core/params/search_params.dart';
import '/core/utils/log_utils.dart';
import '/core/utils/values/strings.dart';
import '/features/home/data/datasources/home_remote_data_source.dart';
import '/features/home/domain/repositories/home_repo.dart';
import '/injection_container.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource remote;
  HomeRepoImpl({required this.remote});

  @override
  Future<Either<Failure, BaseListResponse>> getCities(
      SearchParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final BaseListResponse response = await remote.getCities(params);
        return Right(response);
      } on AppException catch (error) {
        Log.e(
            '[getCities] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }
  
  @override
  Future<Either<Failure, BaseListResponse>> getAllUserGallary() async{
    if (await networkInfo.isConnected) {
      try {
        final  response = await remote.getAllUserGalleryRemoteData();
        
        return Right(response);
      } on AppException catch (error) {
        Log.e(
            '[getAllUserGallary] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }
}
