import '/core/error/exceptions.dart';
import '/core/params/car_params.dart';
import '/core/utils/log_utils.dart';
import '/features/cars/data/models/additional_resp_model.dart';
import '/features/cars/data/models/available_cars_resp_model.dart';
import '/features/cars/data/models/branch_resp_model.dart';
import '/features/cars/data/models/branches_resp_model.dart';
import '/features/cars/data/models/brands_resp_model.dart';
import '/features/cars/data/models/categories_resp_model.dart';
import '/features/cars/data/models/free_additional_resp_model.dart';
import '/injection_container.dart';

abstract class CarsRemoteDataSource {
  Future<AvailableCarsRespModel> getCars({required CarParams params});
  Future<BranchRespModel> getRemoteAgentsByCity({required CarParams params});
  Future<AdditionalResponseModel> getAdditional({required CarParams params});
  Future<FreeAdditionalResponseModel> getFreeAdditional(
      {required CarParams params});
  Future<BrandsRespModel> getBrands();
  Future<CarCategoriesRespModel> getCategories();
  Future<BranchesRespModel> getRemoteBranches({required CarParams params});
}

class CarsRemoteDataSourceImpl implements CarsRemoteDataSource {
  @override
  Future<AvailableCarsRespModel> getCars({required CarParams params}) async {
    try {
      Map<String, dynamic> body = {};
      if (params.recerveDataFrom != null) {
        body['reserve_date_from'] = params.recerveDataFrom;
      }
      if (params.recerveDataTo != null) {
        body['reserve_date_to'] = params.recerveDataTo;
      }

      final Map<String, dynamic> queryParameters = {};
      if (params.cats != null) {
        queryParameters['cats'] = params.cats;
      }
      if (params.brand != null) {
        queryParameters['brands'] = params.brand;
      }
      if (params.fromPrice != null) {
        queryParameters['from_price'] = params.fromPrice;
      }
      if (params.toPrice != null) {
        queryParameters['to_price'] = params.toPrice;
      }
      if (params.plan != null) {
        queryParameters['plan'] = params.plan;
      }
      if (params.sortByLowerPrice != null) {
        queryParameters['sortByLowerPrice'] = params.sortByLowerPrice;
      }
      if (params.sortByLatestYear != null) {
        queryParameters['sortByLatestYear'] = params.sortByLatestYear;
      }
      if (params.onlyCarOffer != null) {
        queryParameters['onlyCarOffer'] = params.onlyCarOffer;
      }
      if (params.latitude != null) {
        queryParameters['latitude'] = params.latitude;
      }
      if (params.longitude != null) {
        queryParameters['longitude'] = params.longitude;
      }
      if (params.branchId != null) {
        queryParameters['branch_id'] = params.branchId;
      }
      if (params.customerId != null) {
        queryParameters['customer_id'] = params.customerId;
      }
      if (params.fromBranchId != null) {
        queryParameters['from_city_id'] = params.fromBranchId;
      }
      Log.i(queryParameters.toString());

      final response = await dioConsumer.post(
        '/car/available_cars',
        queryParameters: queryParameters,
        body: body,
      );

      if (response['status_code'] == 200) {
        return AvailableCarsRespModel.fromJson(response);
      }
      throw ServerException(
          message: appLocalizations.isArLocale
              ? response['details']['message_ar'] ?? response['message']
              : response['details']['message_en'] ?? response['message']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BrandsRespModel> getBrands() async {
    try {
      final response = await dioConsumer.get(
        '/brand/all',
      );

      if (response['status_code'] == 200) {
        return BrandsRespModel.fromJson(response);
      }
      throw ServerException(
        message: appLocalizations.isArLocale
            ? response['details']['message_ar'] ?? response['message']
            : response['details']['message_en'] ?? response['message'],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CarCategoriesRespModel> getCategories() async {
    try {
      final response = await dioConsumer.get(
        '/cat/all',
      );

      if (response['status_code'] == 200) {
        return CarCategoriesRespModel.fromJson(response);
      }
      throw ServerException(
        message: appLocalizations.isArLocale
            ? response['details']['message_ar'] ?? response['message']
            : response['details']['message_en'] ?? response['message'],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AdditionalResponseModel> getAdditional(
      {required CarParams params}) async {
    try {
      final response = await dioConsumer.get(
        '/additional/all/${params.customerId}/${params.cats}',
      );

      if (response['status_code'] == 200) {
        return AdditionalResponseModel.fromJson(response);
      }
      throw ServerException(
        message: appLocalizations.isArLocale
            ? response['details']['message_ar'] ?? response['message']
            : response['details']['message_en'] ?? response['message'],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FreeAdditionalResponseModel> getFreeAdditional(
      {required CarParams params}) async {
    try {
      final response = await dioConsumer.get(
        '/free_additional/all/${params.customerId}/${params.cats}',
      );

      if (response['status_code'] == 200) {
        return FreeAdditionalResponseModel.fromJson(response);
      }
      throw ServerException(
        message: appLocalizations.isArLocale
            ? response['details']['message_ar'] ?? response['message']
            : response['details']['message_en'] ?? response['message'],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BranchRespModel> getRemoteAgentsByCity(
      {required CarParams params}) async {
    try {
      final response = await dioConsumer.get(
        '/branch/city/${params.fromBranchId}',
      );

      if (response['status_code'] == 200) {
        return BranchRespModel.fromJson(response);
      }
      throw ServerException(
        message: appLocalizations.isArLocale
            ? response['details']['message_ar'] ?? response['message']
            : response['details']['message_en'] ?? response['message'],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BranchesRespModel> getRemoteBranches(
      {required CarParams params}) async {
    try {
      final response = await dioConsumer.get(
        '/branch/city/91/customer/82',
        // '/branch/city/${params.cityId}/customer/${params.customerId}',
        queryParameters: {
          'name': params.keyword,
        },
      );
      if (response['status_code'] == 200) {
        return BranchesRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (e) {
      rethrow;
    }
  }
}
