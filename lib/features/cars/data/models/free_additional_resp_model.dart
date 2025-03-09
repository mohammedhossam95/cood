import '/core/base_classes/base_list_response.dart';
import '/features/cars/domain/entities/additional_entity.dart';

class FreeAdditionalResponseModel extends BaseListResponse {
  const FreeAdditionalResponseModel({
    super.message,
    super.status,
    super.data,
  });

  factory FreeAdditionalResponseModel.fromJson(Map<String, dynamic> json) {
    return FreeAdditionalResponseModel(
      message: json['message'],
      status: json['status_code'],
      data: json['details'] != null
          ? (json['details'] as List<dynamic>)
              .map((detail) => FreeAdditionalModel.fromJson(detail))
              .toList()
          : [],
    );
  }
}

class FreeAdditionalModel extends AdditionalEntity {
  const FreeAdditionalModel({
    super.id,
    super.nameEn,
    super.nameAr,
    super.categoryId,
    super.customerId,
  });

  factory FreeAdditionalModel.fromJson(Map<String, dynamic> json) {
    return FreeAdditionalModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      categoryId: json['category_id'],
      customerId: json['customer_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_ar': nameAr,
      'category_id': categoryId,
      'customer_id': customerId,
    };
  }
}
