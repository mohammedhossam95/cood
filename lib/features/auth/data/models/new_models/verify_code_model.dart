import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/features/auth/data/models/login_model.dart';

class VerifyCodeResponseModel extends BaseOneResponse {
  const VerifyCodeResponseModel({
    super.status,
    super.data,
    super.success,
    super.message,
  });

  factory VerifyCodeResponseModel.fromJson(Map<String, dynamic> json) =>
      VerifyCodeResponseModel(
        status: json["status"],
        data:
            json["result"] == null ? null : UserModel.fromJson(json["result"]),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": (data as UserModel?)?.toJson(),
        "success": success,
        "message": message,
      };
}
