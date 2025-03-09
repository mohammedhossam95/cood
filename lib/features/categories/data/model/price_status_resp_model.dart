import 'package:cood/features/categories/domain/entity/price_status_response.dart';

import '/core/base_classes/base_one_response.dart';

class PriceStatusRespModel extends BaseOneResponse {
  const PriceStatusRespModel({
    super.message,
    super.statusCode,
    super.data,
  });

  factory PriceStatusRespModel.fromJson(Map<String, dynamic> json) =>
      PriceStatusRespModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: json["details"] == null
            ? null
            : PriceStatusModel.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "details": data?.toJson(),
      };
}

class PriceStatusModel extends PriceStatus {
  const PriceStatusModel({
    super.reserveId,
    super.paidPointsReyalConverted,
    super.finalPrice,
    super.pointsCoverPrice,
  });

  factory PriceStatusModel.fromJson(Map<String, dynamic> json) =>
      PriceStatusModel(
        reserveId: json["reserve_id"],
        paidPointsReyalConverted: json["paid_points_reyal_converted"],
        finalPrice: json["final_price"],
        pointsCoverPrice: json["points_cover_price"],
      );

  Map<String, dynamic> toJson() => {
        "reserve_id": reserveId,
        "paid_points_reyal_converted": paidPointsReyalConverted,
        "final_price": finalPrice,
        "points_cover_price": pointsCoverPrice,
      };
}
