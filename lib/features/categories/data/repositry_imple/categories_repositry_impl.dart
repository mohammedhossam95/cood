import 'package:cood/features/categories/data/datasource/categories_remote_datesource.dart';
import 'package:cood/features/categories/domain/entity/checkout_response.dart';
import 'package:dartz/dartz.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/base_classes/base_one_response.dart';
import '/core/error/failures.dart';
import '/core/params/car_params.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/log_utils.dart';
import '../../domain/repository/categories_repository.dart';

class CategoriesRepositryImpl extends CategoriesRepositry {
  final CategoriesRemoteDatesource remoteDataSource;
  CategoriesRepositryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, BaseListResponse>> fetchCategories() async {
    try {
      final response = await remoteDataSource.getCategoriesRemoteData();
      Log.d(response.toString());
      return Right(response);
    } on ServerException catch (error) {
      Log.e(
          '[updateRegister] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> checkReserveStatus(
      CarParams params) async {
    try {
      final remoteData =
          await remoteDataSource.checkRemoteReserveStatus(params);

      return Right(remoteData);
    } on ServerException catch (error) {
      return Left(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> reserve(CarParams params) async {
    try {
      final remoteData = await remoteDataSource.makeRemoteReserve(params);
      return Right(remoteData);
    } on ServerException catch (error) {
      return Left(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, CheckoutResponse>> getConfig(CarParams params) async {
    try {
      final remoteData = await remoteDataSource.getRemoteAPayCheckout(params);
      return Right(remoteData);
    } on ServerException catch (error) {
      return Left(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> getPriceStatus(
      CarParams params) async {
    try {
      final remoteData = await remoteDataSource.getRemotePriceStatus(params);
      return Right(remoteData);
    } on ServerException catch (error) {
      return Left(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> completeAPay(
      CarParams params) async {
    try {
      final remoteData = await remoteDataSource.completeRemoteAPay(params);
      return Right(remoteData);
    } on ServerException catch (error) {
      return Left(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, BaseListResponse>> getAdditional(
      int categoryId) async {
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
  }

  @override
  Future<Either<Failure, BaseOneResponse>> getFilterUserByCategory(
      int id) async {
    try {
      final response = await remoteDataSource.getFilterUserByCategoryId(id);
      Log.d(response.toString());
      return Right(response);
    } on ServerException catch (error) {
      Log.e(
          '[getFilterUserById] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left(error.toFailure());
    }
  }
  
  @override
  Future<Either<Failure, BaseListResponse>> postSelectedCategory(List<int> ids) async{
      try {
      final response = await remoteDataSource.postSelectedCategory(ids);
      Log.d(response.toString());
      return Right(response);
    } on ServerException catch (error) {
      Log.e(
          '[postSelectedCategory] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left(error.toFailure());
    }
  }
}
