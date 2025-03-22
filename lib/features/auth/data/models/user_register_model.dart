import 'package:cood/core/base_classes/base_one_response.dart';

import '../../domain/entities/user_register_response.dart';

class UserRegisterRespModel extends BaseOneResponse {
  const UserRegisterRespModel({
    super.status,
    super.data,
    super.success,
    super.message,
  });

  factory UserRegisterRespModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterRespModel(
        status: json["status"],
        data: json["result"] == null
            ? null
            : RegResultModel.fromJson(json["result"]),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "key": key,
        "data": data?.toJson(),
      };
}

class RegResultModel extends RegResult {
  const RegResultModel({
    super.userId,
  });

  factory RegResultModel.fromJson(Map<String, dynamic> json) => RegResultModel(
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
      };
}
