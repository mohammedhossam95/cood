import '/core/error/exceptions.dart';
import '/core/params/search_params.dart';
import '/features/home/data/models/city_resp_model.dart';
import '/features/home/data/models/plans_status_resp_model.dart';
import '/injection_container.dart';

abstract class HomeRemoteDataSource {
  Future<PlansStatusRespModel> getPlansStatus();
  Future<CityRespModel> getCities(SearchParams params);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<PlansStatusRespModel> getPlansStatus() async {
    try {
      final response = await dioConsumer.get(
        '/home/plansStatus',
      );
      if (response['status_code'] == 200) {
        return PlansStatusRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'] ?? '');
      // if (response.runtimeType == List) {
      //   return PlansStatusRespModel.fromJson(response);
      // }
      // throw ServerException(
      //     message: appLocalizations.isArLocale
      //         ? response['details']['message_ar'] ?? response['message']
      //         : response['details']['message_en'] ?? response['message']);
    } catch (e) {
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
