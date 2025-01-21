import '/features/auth/domain/entities/new_entities/login_response.dart';

class LoginResponseModel extends LoginResponse {
  const LoginResponseModel({
    super.message,
    super.statusCode,
    super.time,
    super.details,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        time: json["time"],
        details: json["details"] == null
            ? null
            : LoginDetailsModel.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "time": time,
        "details": (details as LoginDetailsModel?)?.toJson(),
      };
}

class LoginDetailsModel extends LoginDetails {
  const LoginDetailsModel({
    super.token,
    super.id,
    super.loginKey,
    super.session,
    super.username,
    super.role,
    super.status,
  });

  factory LoginDetailsModel.fromJson(Map<String, dynamic> json) =>
      LoginDetailsModel(
        token: json["token"],
        id: json["id"],
        loginKey: json["loginKey"],
        session: json["session"],
        username: json["username"],
        role: json["role"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "id": id,
        "loginKey": loginKey,
        "session": session,
        "username": username,
        "role": role,
        "status": status,
      };
}
