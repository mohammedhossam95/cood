// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

import '/features/auth/domain/entities/new_entities/register_response.dart';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponseModel data) =>
    json.encode(data.toJson());

class RegisterResponseModel extends RegisterResponse {
  const RegisterResponseModel({
    super.message,
    super.statusCode,
    super.time,
    super.details,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        time: json["time"],
        details: json["details"] == null
            ? null
            : RegisterDetailsModel.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "time": time,
        "details": (details as RegisterDetailsModel?)?.toJson(),
      };
}

class RegisterDetailsModel extends RegisterDetails {
  const RegisterDetailsModel({
    super.id,
    super.email,
    super.username,
    super.phoneNumber,
    super.countryCode,
    super.licencePath,
    super.identificationPath,
    super.role,
    super.active,
    super.createdAt,
    super.adminSession,
    super.customerId,
    super.admin,
    super.verified,
    super.banned,
  });

  factory RegisterDetailsModel.fromJson(Map<String, dynamic> json) =>
      RegisterDetailsModel(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        phoneNumber: json["phone_number"],
        countryCode: json["country_code"],
        licencePath: json["licence_path"],
        identificationPath: json["identification_path"],
        role: json["role"],
        active: json["active"],
        createdAt: json["created_at"],
        adminSession: json["admin_session"],
        customerId: json["customer_id"],
        admin: json["_admin"],
        verified: json["_verified"],
        banned: json["_banned"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "phone_number": phoneNumber,
        "country_code": countryCode,
        "licence_path": licencePath,
        "identification_path": identificationPath,
        "role": role,
        "active": active,
        "created_at": createdAt,
        "admin_session": adminSession,
        "customer_id": customerId,
        "_admin": admin,
        "_verified": verified,
        "_banned": banned,
      };
}
