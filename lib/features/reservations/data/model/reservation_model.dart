import '/core/base_classes/base_list_response.dart';
import '/features/cars/data/models/available_cars_resp_model.dart';
import '/features/cars/data/models/branches_resp_model.dart';
import '../../domain/entity/reservation_entity.dart';

class ReservationRespModel extends BaseListResponse {
  // final int? currentPage;
  // final int? totalPages;
  // final int? numberOfItems;
  // final String? time;

  const ReservationRespModel({
    super.message,
    super.statusCode,
    super.data,

    //   super.currentPage,
    // super.totalPages,
    // super.numberOfItems,
  });

  factory ReservationRespModel.fromJson(Map<String, dynamic> json) =>
      ReservationRespModel(
        message: json["message"],
        statusCode: json["status_code"],

        data: json["details"] == null
            ? []
            : List<ReservationModel>.from(
                json["details"]!.map((x) => ReservationModel.fromJson(x))),
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

class ReservationModel extends GetReservation {
  const ReservationModel({
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
    super.canExtend,
    super.createdAt,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      ReservationModel(
        id: json["id"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        additionals: json["additionals"] == null
            ? []
            : List<dynamic>.from(json["additionals"]!.map((x) => x)),
        toBranch: json["to_branch"] == null
            ? null
            : BranchModel.fromJson(json["to_branch"]),
        fromBranch: json["from_branch"] == null
            ? null
            : BranchModel.fromJson(json["from_branch"]),
        promocode: json["promocode"],
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
        canExtend: json["can_extend"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from_date": fromDate,
        "to_date": toDate,
        "additionals": additionals == null
            ? []
            : List<dynamic>.from(additionals!.map((x) => x)),
        "to_branch": toBranch,
        "from_branch": fromBranch,
        "promocode": promocode,
        "promocode_name": promocodeName,
        "price_without_promocode": priceWithoutPromocode,
        "car": car,
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
        "can_extend": canExtend,
        "created_at": createdAt,
      };
}
