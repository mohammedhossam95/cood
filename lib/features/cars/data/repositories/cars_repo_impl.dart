import 'package:dartz/dartz.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/error/exceptions.dart';
import '/core/error/failures.dart';
import '/core/params/car_params.dart';
import '/core/utils/log_utils.dart';
import '/core/utils/values/strings.dart';
import '/features/cars/data/datasources/cars_remote_data_source.dart';
import '/features/cars/data/models/additional_resp_model.dart';
import '/features/cars/data/models/available_cars_resp_model.dart';
import '/features/cars/data/models/branches_resp_model.dart';
import '/features/cars/data/models/brands_resp_model.dart';
import '/features/cars/data/models/categories_resp_model.dart';
import '/features/cars/data/models/free_additional_resp_model.dart';
import '/features/cars/domain/repositories/cars_repo.dart';
import '/injection_container.dart';

class CarsRepoImpl implements CarsRepo {
  final CarsRemoteDataSource remote;
  CarsRepoImpl({required this.remote});
  @override
  Future<Either<Failure, BaseListResponse>> getCars(
      {required CarParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final AvailableCarsRespModel response =
            await remote.getCars(params: params);
        // secureStorage.saveAccessToken(response.token);
        return Right(response);
      } on AppException catch (error) {
        Log.e(
            '[getCars] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, BaseListResponse>> getBrands() async {
    if (await networkInfo.isConnected) {
      try {
        final BrandsRespModel response = await remote.getBrands();
        // secureStorage.saveAccessToken(response.token);
        return Right(response);
      } on AppException catch (error) {
        Log.e(
            '[getBrands] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, BaseListResponse>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final CarCategoriesRespModel response = await remote.getCategories();
        // secureStorage.saveAccessToken(response.token);
        return Right(response);
      } on AppException catch (error) {
        Log.e(
            '[getCategories] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, BaseListResponse>> getAdditional(
      {required CarParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final AdditionalResponseModel response =
            await remote.getAdditional(params: params);
        // secureStorage.saveAccessToken(response.token);
        return Right(response);
      } on AppException catch (error) {
        Log.e(
            '[getAdditional] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, BaseListResponse>> getFreeAdditional(
      {required CarParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final FreeAdditionalResponseModel response =
            await remote.getFreeAdditional(params: params);
        // secureStorage.saveAccessToken(response.token);
        return Right(response);
      } on AppException catch (error) {
        Log.e(
            '[getFreeAdditional] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, BaseListResponse>> getBranches(
      CarParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final BranchesRespModel response =
            await remote.getRemoteBranches(params: params);
        // secureStorage.saveAccessToken(response.token);
        return Right(response);
      } on AppException catch (error) {
        Log.e(
            '[getBranches] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, BaseListResponse>> getAgents(
      {required CarParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final BaseListResponse response =
            await remote.getRemoteAgentsByCity(params: params);

        return Right(response);
      } on AppException catch (error) {
        Log.e(
            '[getBranches] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }
}
