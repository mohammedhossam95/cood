import 'package:cood/features/categories/data/model/checkout_resp_model.dart';
import 'package:cood/features/categories/data/model/get_filter_user_by_category_model.dart';
import 'package:cood/features/categories/data/model/price_status_resp_model.dart';
import 'package:cood/features/categories/data/model/reserve_status_resp_model.dart';

import '/core/params/car_params.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../injection_container.dart';
import '../model/additional_model.dart';
import '../model/categoryies_model.dart';

abstract class CategoriesRemoteDatesource {
  //--------------new
  Future<FilterUserByCategoryRespModel> getFilterUserByCategoryId(int id);
  Future<CategoriesRespModel> getCategoriesRemoteData();
  //-----------------------------------------
  Future<ReserveStatusRespModel> checkRemoteReserveStatus(CarParams params);
  Future<ReserveStatusRespModel> makeRemoteReserve(CarParams params);
  Future<CheckoutRespModel> getRemoteAPayCheckout(CarParams params);
  Future<PriceStatusRespModel> getRemotePriceStatus(CarParams params);
  Future<ReserveStatusRespModel> completeRemoteAPay(CarParams params);
  Future<AdditionalRespModel> getAdditionalRemoteData(int categoryId);
}

class CategoriesRemoteDatesourceImpl extends CategoriesRemoteDatesource {
    @override
  Future<FilterUserByCategoryRespModel> getFilterUserByCategoryId(int id) async{
    String branchUrl = '/users/filter-by-category';
    try {
  final response = await dioConsumer.get(
    branchUrl,
    queryParameters: {
      "category_id":id,
    }
    );
  if (response['status'] == 'success' && response['result'] != null) {
    return FilterUserByCategoryRespModel.fromJson(response);
  }
      throw ServerException(message: response['message'] ?? '');
} on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
  @override
  Future<CategoriesRespModel> getCategoriesRemoteData() async {
    String branchUrl = 'https://cood.testworks.top/api/v1/categories';
    try {
      final response = await dioConsumer.get(
        branchUrl,
      );
      if (response['status'] == 'success' && response['result'] != null) {
        return CategoriesRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'] ?? '');
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ReserveStatusRespModel> checkRemoteReserveStatus(
      CarParams params) async {
    try {
      final response = await dioConsumer.post(
        "https://jzl-sa.net/api/v1/reserve_status",
        body: {
          "car_id": params.carId,
          "plan": params.plan,
          "from_date": params.recerveDataFrom,
          "to_date": params.recerveDataTo,
          "from_branch_id": params.fromBranchId,
          "to_branch_id": params.toBranchId,
          "customer_id": params.customerId,
          "additional_ids": params.additionalIds,
        },
      );
      ReserveStatusRespModel model = ReserveStatusRespModel.fromJson(response);
      return model;
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ReserveStatusRespModel> makeRemoteReserve(CarParams params) async {
    try {
      final response = await dioConsumer.post(
        "https://jzl-sa.net/api/v1/reserve",
        body: {
          "car_id": params.carId,
          "plan": params.plan,
          "from_date": params.recerveDataFrom,
          "to_date": params.recerveDataTo,
          "from_branch_id": params.fromBranchId,
          "to_branch_id": params.toBranchId,
          "customer_id": params.customerId,
          "additional_ids": params.additionalIds,
        },
      );
      ReserveStatusRespModel model = ReserveStatusRespModel.fromJson(response);
      return model;
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<CheckoutRespModel> getRemoteAPayCheckout(CarParams params) async {
    throw UnimplementedError();
    // try {
    //   final response = await dioConsumer.postWithCustomHeaders(
    //     ApiConstants.appleCheckOut,
    //     body: {
    //       'entityId': ApiConstants.entityId,
    //       'amount': params.amount,
    //       'currency': 'SAR',
    //       'paymentType': 'DB',
    //     },
    //     headers: {
    //       'Content-Type': 'application/x-www-form-urlencoded',
    //       'Accept': 'application/json',
    //       'Authorization': ApiConstants.liveAccessToken,
    //     },
    //   );
    //   CheckoutRespModel model = CheckoutRespModel.fromJson(response);
    //   return model;
    // } on ServerException {
    //   rethrow;
    // } catch (error) {
    //   rethrow;
    // }
  }

  @override
  Future<PriceStatusRespModel> getRemotePriceStatus(CarParams params) async {
    try {
      final response = await dioConsumer.get(
        "/v1/price_status/${params.branchId}?use_points=true",
      );
      PriceStatusRespModel model = PriceStatusRespModel.fromJson(response);
      return model;
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ReserveStatusRespModel> completeRemoteAPay(CarParams params) async {
    try {
      Map<String, dynamic> queryParameters = {
        "reserve_id": params.branchId,
        // "payment_id": params.checkoutId,
      };
      final response = await dioConsumer.get(
        "v1/complete_applepay/0d0df",
        queryParameters: queryParameters,
      );

      ReserveStatusRespModel model = ReserveStatusRespModel.fromJson(response);
      return model;
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<AdditionalRespModel> getAdditionalRemoteData(int categoryId) async {
    String additionalUrl = '/v1/additional/cat/$categoryId';
    try {
      final response = await dioConsumer.get(
        additionalUrl,
      );
      if (response['status_code'] == 200) {
        return AdditionalRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'] ?? '');
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }


}
