import '../../../../core/base_classes/base_one_response.dart';

class DeleteMyAccountRespModel extends BaseOneResponse {
  const DeleteMyAccountRespModel({
    super.value,
    super.key,
    super.data,
  });

  factory DeleteMyAccountRespModel.fromJson(Map<String, dynamic> json) =>
      DeleteMyAccountRespModel(
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
