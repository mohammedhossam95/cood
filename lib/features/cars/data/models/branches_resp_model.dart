import '/core/base_classes/base_list_response.dart';
import '/features/cars/domain/entities/branch_entity.dart';
import '/features/home/data/models/city_resp_model.dart';

class BranchesRespModel extends BaseListResponse {
  const BranchesRespModel({super.data, super.status, super.message});

  factory BranchesRespModel.fromJson(Map<String, dynamic> json) {
    return BranchesRespModel(
      status: json["status_code"],
      message: json["message"],
      data: json["details"] == null
          ? []
          : List<BranchModel>.from(
              json["details"]!.map((x) => BranchModel.fromJson(x))),
    );
  }
}

class BranchModel extends Branch {
  const BranchModel({
    super.id,
    super.nameEn,
    super.nameAr,
    super.cityId,
    super.city,
    super.longitude,
    super.latitude,
    super.phoneNumber,
    super.phoneNumberTwo,
    super.email,
    super.rowOrder,
    super.deleted,
    super.customerId,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      cityId: json['city_id'],
      city: json['city'] != null ? CityModel.fromJson(json['city']) : null,
      longitude: json['longitude'],
      latitude: json['latitude'],
      phoneNumber: json['phone_number'],
      phoneNumberTwo: json['phone_number_two'],
      email: json['email'],
      rowOrder: json['row_order'],
      deleted: json['deleted'],
      customerId: json['customer_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_ar': nameAr,
      'city_id': cityId,
      'city': (city as CityModel?)?.toJson(),
      'longitude': longitude,
      'latitude': latitude,
      'phone_number': phoneNumber,
      'phone_number_two': phoneNumberTwo,
      'email': email,
      'row_order': rowOrder,
      'deleted': deleted,
      'customer_id': customerId,
    };
  }
}
