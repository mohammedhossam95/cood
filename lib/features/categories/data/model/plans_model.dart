import '/core/base_classes/base_one_response.dart';

class PlansRespModel extends BaseOneResponse {
  const PlansRespModel({
    super.message,
    super.statusCode,
    super.data,
  });

  factory PlansRespModel.fromJson(Map<String, dynamic> json) => PlansRespModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: json["details"] == null
            ? null
            : PlansDetails.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "details": data?.toJson(),
      };
}

class PlansDetails {
  final bool? weekly;
  final bool? daily;
  final bool? monthly;

  PlansDetails({
    this.weekly,
    this.daily,
    this.monthly,
  });

  factory PlansDetails.fromJson(Map<String, dynamic> json) => PlansDetails(
        weekly: json["WEEKLY"],
        daily: json["DAILY"],
        monthly: json["MONTHLY"],
      );

  Map<String, dynamic> toJson() => {
        "WEEKLY": weekly,
        "DAILY": daily,
        "MONTHLY": monthly,
      };
}
