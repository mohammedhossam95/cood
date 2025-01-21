import '/core/base_classes/base_list_response.dart';
import '/features/cars/domain/entities/additional_entity.dart';

class AdditionalResponseModel extends BaseListResponse {
  const AdditionalResponseModel({
    super.message,
    super.statusCode,
    super.data,
  });

  factory AdditionalResponseModel.fromJson(Map<String, dynamic> json) {
    return AdditionalResponseModel(
      message: json['message'],
      statusCode: json['status_code'],
      data: json['details'] != null
          ? (json['details'] as List<dynamic>)
              .map((detail) => AdditionalModel.fromJson(detail))
              .toList()
          : [],
    );
  }
}

class AdditionalModel extends AdditionalEntity {
  const AdditionalModel({
    super.id,
    super.nameEn,
    super.nameAr,
    super.descEn,
    super.descAr,
    super.price,
    super.minReserveDays,
    super.termsEn,
    super.termsAr,
    super.categoryId,
    super.deleted,
    super.customerId,
    super.allPrice,
  });

  factory AdditionalModel.fromJson(Map<String, dynamic> json) {
    return AdditionalModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      descEn: json['desc_en'],
      descAr: json['desc_ar'],
      price: json['price'],
      minReserveDays: json['min_reserve_days'],
      termsEn: json['terms_en'],
      termsAr: json['terms_ar'],
      categoryId: json['category_id'],
      deleted: json['deleted'],
      customerId: json['customer_id'],
      allPrice: json['_all_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_ar': nameAr,
      'desc_en': descEn,
      'desc_ar': descAr,
      'price': price,
      'min_reserve_days': minReserveDays,
      'terms_en': termsEn,
      'terms_ar': termsAr,
      'category_id': categoryId,
      'deleted': deleted,
      'customer_id': customerId,
      '_all_price': allPrice,
    };
  }
}
