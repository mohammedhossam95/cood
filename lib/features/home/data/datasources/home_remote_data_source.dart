import 'package:cood/features/home/data/models/friend_lIst_model.dart';
import 'package:cood/features/home/data/models/get_user_social_media_model.dart';
import 'package:cood/features/home/data/models/user_gallary_model.dart';
import '/core/error/exceptions.dart';
import '/core/params/search_params.dart';
import '/features/home/data/models/city_resp_model.dart';
import '/injection_container.dart';

abstract class HomeRemoteDataSource {
  //--------------new
  Future<UserGalleryRespModel> getAllUserGalleryRemoteData();
  Future<FriendListRespModel> getFriendsList();
  Future<SocialMediaRespModel> getUserSocialMedia();
  Future<SocialMediaRespModel> getAllSocialMedia();
  //-------------------------
  Future<CityRespModel> getCities(SearchParams params);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<FriendListRespModel> getFriendsList() async{
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
  String galleryUrl = 'https://cood.testworks.top/api/v1/gallery'; // Replace with the actual endpoint
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
  Future<SocialMediaRespModel> getUserSocialMedia() async{
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
  Future<SocialMediaRespModel> getAllSocialMedia() async{
    String branchUrl = 'https://cood.testworks.top/api/v1/social-media'; 
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
  

  

}
