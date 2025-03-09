import '/core/base_classes/base_list_response.dart';
import '/features/cars/domain/entities/car_brand_entity.dart';

class BrandsRespModel extends BaseListResponse {
  const BrandsRespModel({
    super.data,
    super.message,
    super.status,
  });

  factory BrandsRespModel.fromJson(Map<String, dynamic> json) {
    return BrandsRespModel(
      message: json['message'],
      status: json['status'],
      data: (json['details'] == null ? [] : json['details'] as List<dynamic>?)
          ?.map((category) => BrandsModel.fromJson(category))
          .toList(),
    );
  }
}

class BrandsModel extends CarBrand {
  const BrandsModel({
    super.id,
    super.nameEn,
    super.nameAr,
    super.imagePath,
  });

  factory BrandsModel.fromJson(Map<String, dynamic> json) {
    return BrandsModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      imagePath: json['image_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_ar': nameAr,
      'image_path': imagePath,
    };
  }
}
