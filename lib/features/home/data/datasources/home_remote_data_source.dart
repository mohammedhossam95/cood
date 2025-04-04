import 'package:cood/features/home/data/models/add_user_account_model.dart';
import 'package:cood/features/home/data/models/friend_list_resp_model.dart';
import 'package:cood/features/home/data/models/get_all_social_media_model.dart';
import 'package:cood/features/home/data/models/get_pending_requests_model.dart';
import 'package:cood/features/home/data/models/get_user_social_media_model.dart';
import 'package:cood/features/home/data/models/search_user_by_code_model.dart';
import 'package:cood/features/home/data/models/send_friend_request_model.dart';
import 'package:cood/features/home/data/models/user_gallary_model.dart';

import '/core/error/exceptions.dart';
import '/core/params/search_params.dart';
import '/features/home/data/models/city_resp_model.dart';
import '/injection_container.dart';
import '../../../../core/params/add_user_account.dart';

abstract class HomeRemoteDataSource {
  //--------------new
    Future<PendingRequestsRespModel> getPendingRequest();
  Future<SendFriendRequestRespModel> sendFreindRequest(int id);
  Future<SearchUserByCodeRespModel> getSearchUserByCode(String params);
  Future<UserGalleryRespModel> getAllUserGalleryRemoteData();
  Future<FriendListRespModel> getFriendsList();
  Future<SocialMediaRespModel> getUserSocialMedia();
  Future<AllSocialMediaRespModel> getAllSocialMedia();
  Future<AddUserSocialAccountRespModel> addUserSocialAccount(
      AddAccountParams params);
  //-------------------------
  Future<CityRespModel> getCities(SearchParams params);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<FriendListRespModel> getFriendsList() async {
    String branchUrl = 'https://cood.testworks.top/api/v1/friends';
    try {
      final response = await dioConsumer.get(branchUrl);
      if (response['status'] == 'success' && response['result'] != null) {
        return FriendListRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'].toString());
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<UserGalleryRespModel> getAllUserGalleryRemoteData() async {
    String galleryUrl =
        'https://cood.testworks.top/api/v1/gallery'; // Replace with the actual endpoint
    try {
      final response = await dioConsumer.get(galleryUrl);
      if (response['status'] == 'success' && response['result'] != null) {
        return UserGalleryRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'].toString());
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<SocialMediaRespModel> getUserSocialMedia() async {
    String branchUrl = 'https://cood.testworks.top/api/v1/user/social-media';
    try {
      final response = await dioConsumer.get(branchUrl);
      if (response['status'] == 'success' && response['result'] != null) {
        return SocialMediaRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'].toString());
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<AllSocialMediaRespModel> getAllSocialMedia() async {
    String branchUrl = 'https://cood.testworks.top/api/v1/social-media';
    try {
      final response = await dioConsumer.get(branchUrl);
      if (response['status'] == 'success' && response['result'] != null) {
        return AllSocialMediaRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'].toString());
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<CityRespModel> getCities(SearchParams params) async {
    try {
      final response = await dioConsumer.get(
        '/city/all',
        queryParameters: {
          'name': params.keyword,
        },
      );
      if (response['status_code'] == 200) {
        return CityRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AddUserSocialAccountRespModel> addUserSocialAccount(
      AddAccountParams params) async {
    String branchUrl = '/user/social-media';
    try {
      final response = await dioConsumer.post(
        branchUrl,
        body: params.toJson(),
      );
      if (response['status'] == 'success') {
        return AddUserSocialAccountRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'].toString());
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  //------------search user by code
  @override
  Future<SearchUserByCodeRespModel> getSearchUserByCode(
      String code) async {
    String branchUrl = "/friends/search-by-code";
    try {
      final response = await dioConsumer.get(branchUrl, queryParameters: {
        "code": code,
      });
      if (response['status'] == 'success'&& response['result'] != null) {
        return SearchUserByCodeRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'].toString());
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
  
  @override
  Future<SendFriendRequestRespModel> sendFreindRequest(int id)async {
    String branchUrl = '/friends/request';
    try {
      final response = await dioConsumer.post(
        branchUrl,
        body:{
            "receiver_id": id,
        },
      );
      if (response['status'] == 'success') {
        return SendFriendRequestRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'].toString());
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
  //----------------get pending requests
  @override
  Future<PendingRequestsRespModel> getPendingRequest() async{
    String branchUrl = "/friends/requests";
    try {
      final response = await dioConsumer.get(branchUrl);
      if (response['status'] == 'success'&& response['result'] != null) {
        return PendingRequestsRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'].toString());
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
