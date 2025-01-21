import '/core/base_classes/base_one_response.dart';
import '/features/home/domain/entities/plans_status_entity.dart';

class PlansStatusRespModel extends BaseOneResponse {
  const PlansStatusRespModel({
    super.data,
    super.statusCode,
    super.message,
  });

  factory PlansStatusRespModel.fromJson(json) {
    return PlansStatusRespModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: PlansStatusModel.fromJson(json["details"]));
  }
}

class PlansStatusModel extends PlansStatusEntity {
  const PlansStatusModel({
    super.weekly,
    super.daily,
    super.monthly,
  });

  factory PlansStatusModel.fromJson(Map<String, dynamic> json) {
    return PlansStatusModel(
      weekly: json['WEEKLY'],
      daily: json['DAILY'],
      monthly: json['MONTHLY'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'WEEKLY': weekly,
      'DAILY': daily,
      'MONTHLY': monthly,
    };
  }
}
