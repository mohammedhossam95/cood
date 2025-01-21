import '/core/base_classes/base_list_response.dart';
import '/features/cars/domain/entities/car_entity.dart';

class CityRespModel extends BaseListResponse {
  const CityRespModel({super.data, super.statusCode, super.message});

  factory CityRespModel.fromJson(json) {
    return CityRespModel(
      statusCode: json["status_code"],
      message: json["message"],
      data: json["details"] == null
          ? []
          : List<CityModel>.from(
              json["details"]!.map((x) => CityModel.fromJson(x))),
    );
  }
}

class CityModel extends City {
  const CityModel({
    super.id,
    super.nameEn,
    super.nameAr,
    super.deleted,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      deleted: json['deleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_ar': nameAr,
      'deleted': deleted,
    };
  }
}
