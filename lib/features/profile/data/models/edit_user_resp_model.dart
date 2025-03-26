import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/features/auth/data/models/login_model.dart';

class EditUserRespModel extends BaseOneResponse {
  const EditUserRespModel({
    super.status,
    super.data,
    super.success,
    super.message,
  });

  factory EditUserRespModel.fromJson(Map<String, dynamic> json) =>
      EditUserRespModel(
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
