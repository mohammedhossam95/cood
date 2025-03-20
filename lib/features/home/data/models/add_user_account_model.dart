import 'package:cood/core/base_classes/base_list_response.dart';

class AddUserSocialAccountRespModel extends BaseListResponse{
  

  const  AddUserSocialAccountRespModel({
        super.status,
        super.data,
        super.success,
        super.message,
    });

    factory AddUserSocialAccountRespModel.fromJson(Map<String, dynamic> json) => AddUserSocialAccountRespModel(
        status: json["status"],
        data: json["result"] == null ? [] : List<dynamic>.from(json["result"]!.map((x) => x)),
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "result": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "success": success,
        "message": message,
    };
}