import 'package:equatable/equatable.dart';

import '../../../../core/base_classes/base_list_response.dart';

class AdditionalRespModel extends BaseListResponse {
  const AdditionalRespModel({
    super.message,
    super.statusCode,
    super.data,
  });

  factory AdditionalRespModel.fromJson(Map<String, dynamic> json) =>
      AdditionalRespModel(
        message: json["message"],
        statusCode: json["status_code"],

        data: json["details"] == null
            ? []
            : List<AdditionalDetail>.from(
                json["details"]!.map((x) => AdditionalDetail.fromJson(x))),
        // currentPage: json["current_page"],
        // totalPages: json["total_pages"],
        // numberOfItems: json["number_of_items"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,

        "details": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        // "current_page": currentPage,
        // "total_pages": totalPages,
        // "number_of_items": numberOfItems,
      };
}

class AdditionalDetail extends Equatable {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final String? descEn;
  final String? descAr;
  final int? price;
  final bool? isAllPrice;
  final int? minReserveDays;
  final String? termsEn;
  final String? termsAr;
  final int? categoryId;
  final bool? deleted;

  const AdditionalDetail({
    this.id,
    this.nameEn,
    this.nameAr,
    this.descEn,
    this.descAr,
    this.price,
    this.isAllPrice,
    this.minReserveDays,
    this.termsEn,
    this.termsAr,
    this.categoryId,
    this.deleted,
  });

  factory AdditionalDetail.fromJson(Map<String, dynamic> json) =>
      AdditionalDetail(
        id: json["id"],
        nameEn: json["name_en"],
        nameAr: json["name_ar"],
        descEn: json["desc_en"],
        descAr: json["desc_ar"],
        price: json["price"],
        isAllPrice: json["is_all_price"],
        minReserveDays: json["min_reserve_days"],
        termsEn: json["terms_en"],
        termsAr: json["terms_ar"],
        categoryId: json["category_id"],
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "name_ar": nameAr,
        "desc_en": descEn,
        "desc_ar": descAr,
        "price": price,
        "is_all_price": isAllPrice,
        "min_reserve_days": minReserveDays,
        "terms_en": termsEn,
        "terms_ar": termsAr,
        "category_id": categoryId,
        "deleted": deleted,
      };

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        descEn,
        descAr,
        price,
        isAllPrice,
        minReserveDays,
        termsEn,
        termsAr,
        categoryId,
        deleted,
      ];
}
