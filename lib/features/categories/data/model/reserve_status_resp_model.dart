import 'package:cood/features/categories/data/model/additional_model.dart';
import 'package:cood/features/categories/data/model/promocode_model.dart';
import 'package:cood/features/categories/domain/entity/reserve_status.dart';

import '/core/base_classes/base_one_response.dart';
import '/features/cars/data/models/available_cars_resp_model.dart';
import '/features/cars/data/models/branches_resp_model.dart';


class ReserveStatusRespModel extends BaseOneResponse {
  const ReserveStatusRespModel({
    super.message,
    super.statusCode,
    super.data,
  });

  factory ReserveStatusRespModel.fromJson(Map<String, dynamic> json) =>
      ReserveStatusRespModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: json["details"] == null
            ? null
            : ReserveDetailsModel.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "details": data?.toJson(),
      };
}

class ReserveDetailsModel extends ReserveDetails {
  const ReserveDetailsModel({
    super.id,
    super.fromDate,
    super.toDate,
    super.additionals,
    super.toBranch,
    super.fromBranch,
    super.promocode,
    super.promocodeName,
    super.priceWithoutPromocode,
    super.car,
    super.finalPrice,
    super.additionalsPrice,
    super.pricePerDay,
    super.cityFees,
    super.numberOfDays,
    super.type,
    super.status,
    super.isPaid,
    super.isExtend,
    super.originalReserveId,
    super.paymentCode,
    super.canExtend,
    super.createdAt,
    super.plan,
  });

  factory ReserveDetailsModel.fromJson(Map<String, dynamic> json) =>
      ReserveDetailsModel(
        id: json["id"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        additionals: json["additionals"] == null
            ? []
            : List<AdditionalDetail>.from(
                json["additionals"]!.map((x) => AdditionalDetail.fromJson(x))),
        toBranch: json["to_branch"] == null
            ? null
            : BranchModel.fromJson(json["to_branch"]),
        fromBranch: json["from_branch"] == null
            ? null
            : BranchModel.fromJson(json["from_branch"]),
        promocode: json["promocode"] == null
            ? null
            : PromocodeModel.fromJson(json["promocode"]),
        promocodeName: json["promocode_name"],
        priceWithoutPromocode: json["price_without_promocode"],
        car: json["car"] == null ? null : CarModel.fromJson(json["car"]),
        finalPrice: json["final_price"],
        additionalsPrice: json["additionals_price"],
        pricePerDay: json["price_per_day"],
        cityFees: json["city_fees"],
        numberOfDays: json["numberOfDays"],
        type: json["type"],
        status: json["status"],
        isPaid: json["is_paid"],
        isExtend: json["is_extend"],
        originalReserveId: json["original_reserve_id"],
        paymentCode: json["payment_code"],
        canExtend: json["can_extend"],
        createdAt: json["created_at"],
        plan: json["plan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from_date": fromDate,
        "to_date": toDate,
        "additionals": additionals == null
            ? []
            : List<dynamic>.from(additionals!.map((x) => x)),
        "to_branch": (toBranch as BranchModel?)?.toJson(),
        "from_branch": (fromBranch as BranchModel?)?.toJson(),
        "promocode": promocode,
        "promocode_name": promocodeName,
        "price_without_promocode": priceWithoutPromocode,
        "final_price": finalPrice,
        "additionals_price": additionalsPrice,
        "price_per_day": pricePerDay,
        "city_fees": cityFees,
        "numberOfDays": numberOfDays,
        "type": type,
        "status": status,
        "is_paid": isPaid,
        "is_extend": isExtend,
        "original_reserve_id": originalReserveId,
        "payment_code": paymentCode,
        "can_extend": canExtend,
        "created_at": createdAt,
        "plan": plan,
      };
}
