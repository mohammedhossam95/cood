import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/core/params/add_user_account.dart';
import 'package:dartz/dartz.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/error/failures.dart';
import '/core/params/search_params.dart';

abstract class HomeRepo {
  //-----------------new-----------------
  Future<Either<Failure, BaseListResponse>> getPendingRequests();
  Future<Either<Failure, BaseOneResponse>> sendFriendRequest(int id);
  Future<Either<Failure, BaseOneResponse>> searchUserByCode(String code);
  Future<Either<Failure, BaseListResponse>> getAllUserGallary();
  Future<Either<Failure, BaseListResponse>> getFriendsList();
  Future<Either<Failure, BaseListResponse>> getUserSocialMedia();
  Future<Either<Failure, BaseListResponse>> getAllSocialMedia();
  Future<Either<Failure, BaseListResponse>> addUserSocialAccount(
      AddAccountParams params);
//----------------------------
  Future<Either<Failure, BaseListResponse>> getCities(SearchParams params);
}
