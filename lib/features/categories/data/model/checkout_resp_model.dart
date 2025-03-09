
import 'package:cood/features/categories/domain/entity/checkout_response.dart';

class CheckoutRespModel extends CheckoutResponse {
  const CheckoutRespModel({
    super.result,
    super.buildNumber,
    super.timestamp,
    super.ndc,
    super.id,
  });

  factory CheckoutRespModel.fromJson(Map<String, dynamic> json) =>
      CheckoutRespModel(
        result: json["result"] == null
            ? null
            : ResultModel.fromJson(json["result"]),
        buildNumber: json["buildNumber"],
        timestamp: json["timestamp"],
        ndc: json["ndc"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "result": (result as ResultModel?)?.toJson(),
        "buildNumber": buildNumber,
        "timestamp": timestamp,
        "ndc": ndc,
        "id": id,
      };
}

class ResultModel extends Result {
  const ResultModel({
    super.code,
    super.description,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
      };
}
