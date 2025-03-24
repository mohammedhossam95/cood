import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/core/params/add_user_account.dart';
import 'package:dartz/dartz.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/error/exceptions.dart';
import '/core/error/failures.dart';
import '/core/params/search_params.dart';
import '/core/utils/log_utils.dart';
import '/features/home/data/datasources/home_remote_data_source.dart';
import '/features/home/domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource remote;
  HomeRepoImpl({required this.remote});

  @override
  Future<Either<Failure, BaseListResponse>> getCities(
      SearchParams params) async {
    try {
      final BaseListResponse response = await remote.getCities(params);
      return Right(response);
    } on AppException catch (error) {
      Log.e(
          '[getCities] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, BaseListResponse>> getAllUserGallary() async {
    try {
      final response = await remote.getAllUserGalleryRemoteData();

      return Right(response);
    } on AppException catch (error) {
      Log.e(
          '[getAllUserGallary] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, BaseListResponse>> getFriendsList() async {
    try {
      final response = await remote.getFriendsList();

      return Right(response);
    } on AppException catch (error) {
      Log.e(
          '[getFrindsList] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, BaseListResponse>> getUserSocialMedia() async {
    try {
      final response = await remote.getUserSocialMedia();
      return Right(response);
    } on AppException catch (error) {
      Log.e(
          '[getUsersocialMedia] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, BaseListResponse>> getAllSocialMedia() async {
    try {
      final response = await remote.getAllSocialMedia();
      return Right(response);
    } on AppException catch (error) {
      Log.e(
          '[getAllSocialMedia] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, BaseListResponse>> addUserSocialAccount(
      AddAccountParams params) async {
    try {
      final response = await remote.addUserSocialAccount(params);
      return Right(response);
    } on AppException catch (error) {
      Log.e(
          '[AddUserSocialMediaAccount] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> searchUserByCode(
      String code) async {
    try {
      final response = await remote.getSearchUserByCode(code);
      return Right(response);
    } on AppException catch (error) {
      Log.e(
          '[GetSearchUserByCode] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left(error.toFailure());
    }
  }
  
  @override
  Future<Either<Failure, BaseOneResponse>> sendFriendRequest(int id) async{
    try {
      final response = await remote.sendFreindRequest(id);
      return Right(response);
    } on AppException catch (error) {
      Log.e(
          '[SendFriendRequest] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left(error.toFailure());
    }
  }
  
  @override
  Future<Either<Failure, BaseListResponse>> getPendingRequests()async {
    try {
      final response = await remote.getPendingRequest();
      return Right(response);
    } on AppException catch (error) {
      Log.e(
          '[GetPendingRequest] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left(error.toFailure());
    }
  }
}
