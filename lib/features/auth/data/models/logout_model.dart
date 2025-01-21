import '/core/base_classes/base_one_response.dart';

class LogOutRespModel extends BaseOneResponse {
  const LogOutRespModel({
    super.value,
    super.key,
    super.data,
  });

  factory LogOutRespModel.fromJson(Map<String, dynamic> json) =>
      LogOutRespModel(
        value: json["value"],
        key: json["key"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "key": key,
        "data": data,
      };
}
