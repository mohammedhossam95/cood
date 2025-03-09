
import 'package:cood/features/categories/data/datasource/categories_remote_datesource.dart';
import 'package:cood/features/categories/domain/entity/checkout_response.dart';
import 'package:dartz/dartz.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/base_classes/base_one_response.dart';
import '/core/error/failures.dart';
import '/core/params/car_params.dart';
import '/core/utils/values/strings.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/log_utils.dart';
import '../../../../injection_container.dart';
import '../../domain/repository/categories_repository.dart';

class CategoriesRepositryImpl extends CategoriesRepositry {
  final CategoriesRemoteDatesource remoteDataSource;
  CategoriesRepositryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, BaseListResponse>> fetchCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getCategoriesRemoteData();
        Log.d(response.toString());
        return Right(response);
      } on ServerException catch (error) {
        Log.e(
            '[updateRegister] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> checkReserveStatus(
      CarParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData =
            await remoteDataSource.checkRemoteReserveStatus(params);

        return Right(remoteData);
      } on ServerException catch (error) {
        return Left(error.toFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> reserve(CarParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.makeRemoteReserve(params);
        return Right(remoteData);
      } on ServerException catch (error) {
        return Left(error.toFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, CheckoutResponse>> getConfig(CarParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getRemoteAPayCheckout(params);
        return Right(remoteData);
      } on ServerException catch (error) {
        return Left(error.toFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> getPriceStatus(
      CarParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getRemotePriceStatus(params);
        return Right(remoteData);
      } on ServerException catch (error) {
        return Left(error.toFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> completeAPay(
      CarParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.completeRemoteAPay(params);
        return Right(remoteData);
      } on ServerException catch (error) {
        return Left(error.toFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> getPlans() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getPlans();
        Log.d(response.toString());
        return Right(response);
      } on ServerException catch (error) {
        Log.e(
            '[updateRegister] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, BaseListResponse>> getAdditional(
      int categoryId) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.getAdditionalRemoteData(categoryId);
        Log.d(response.toString());
        return Right(response);
      } on ServerException catch (error) {
        Log.e(
            '[updateRegister] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }
}
