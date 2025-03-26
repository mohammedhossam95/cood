import '../../domain/entities/login_response.dart';

class LoginRespModel extends LoginResponse {
  const LoginRespModel({
    super.status,
    super.result,
    super.success,
    super.message,
  });

  factory LoginRespModel.fromJson(Map<String, dynamic> json) => LoginRespModel(
        status: json["status"],
        result: json["result"] == null
            ? null
            : LoginResultModel.fromJson(json["result"]),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": (result as LoginResultModel?)?.toJson(),
        "success": success,
        "message": message,
      };
}

class LoginResultModel extends LoginResult {
  const LoginResultModel({
    super.user,
    super.token,
  });

  factory LoginResultModel.fromJson(Map<String, dynamic> json) =>
      LoginResultModel(
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": (user as UserModel?)?.toJson(),
        "token": token,
      };
}

class UserModel extends User {
  const UserModel({
    super.id,
    super.name,
    super.phone,
    super.fcmDeviceKey,
    super.code,
    super.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        fcmDeviceKey: json["fcm_device_key"],
        code: json["code"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "fcm_device_key": fcmDeviceKey,
        "code": code,
        "image": image,
      };
}
