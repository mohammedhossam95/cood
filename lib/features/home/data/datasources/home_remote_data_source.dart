import 'package:cood/features/home/data/models/user_gallary_model.dart';
import '/core/error/exceptions.dart';
import '/core/params/search_params.dart';
import '/features/home/data/models/city_resp_model.dart';
import '/injection_container.dart';

abstract class HomeRemoteDataSource {
  //--------------new
  Future<UserGalleryRespModel> getAllUserGalleryRemoteData();
  //-------------------------
  Future<CityRespModel> getCities(SearchParams params);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<UserGalleryRespModel> getAllUserGalleryRemoteData() async {
  String galleryUrl = 'https://cood.testworks.top/api/v1/gallery'; // Replace with the actual endpoint
  try {
    final response = await dioConsumer.get(galleryUrl);
    if (response['status'] == 'success' && response['result'] != null) {
      return UserGalleryRespModel.fromJson(response);
    }
    throw ServerException(message: response['message'] ?? 'An error occurred.');
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
