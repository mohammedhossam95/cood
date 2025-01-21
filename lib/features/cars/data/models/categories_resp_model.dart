import '/core/base_classes/base_list_response.dart';
import '/features/cars/domain/entities/category_entity.dart';

class CarCategoriesRespModel extends BaseListResponse {
  const CarCategoriesRespModel({
    super.data,
    super.message,
    super.statusCode,
  });

  factory CarCategoriesRespModel.fromJson(Map<String, dynamic> json) {
    return CarCategoriesRespModel(
      message: json['message'],
      statusCode: json['status_code'],
      data: (json['details'] == null ? [] : json['details'] as List<dynamic>?)
          ?.map((category) => CarCategoryModel.fromJson(category))
          .toList(),
    );
  }
}

class CarCategoryModel extends CarCategoryEntity {
  const CarCategoryModel({
    super.id,
    super.nameEn,
    super.nameAr,
    super.imagePath,
    super.deleted,
  });

  factory CarCategoryModel.fromJson(Map<String, dynamic> json) {
    return CarCategoryModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      imagePath: json['image_path'],
      deleted: json['deleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_ar': nameAr,
      'image_path': imagePath,
      'deleted': deleted,
    };
  }
}
