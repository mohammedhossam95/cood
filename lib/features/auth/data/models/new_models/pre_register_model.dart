// To parse this JSON data, do
//
//     final preRegisterResponse = preRegisterResponseFromJson(jsonString);

import 'dart:convert';

import '/features/auth/domain/entities/new_entities/pre_register_response.dart';

PreRegisterResponse preRegisterResponseFromJson(String str) =>
    PreRegisterResponseModel.fromJson(json.decode(str));

String preRegisterResponseToJson(PreRegisterResponseModel data) =>
    json.encode(data.toJson());

class PreRegisterResponseModel extends PreRegisterResponse {
  const PreRegisterResponseModel({
    super.message,
    super.statusCode,
    super.time,
    super.details,
  });

  factory PreRegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      PreRegisterResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        time: json["time"],
        details: json["details"] == null
            ? null
            : PreRegisterDetailsModel.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "time": time,
        "details": (details as PreRegisterDetailsModel?)?.toJson(),
      };
}

class PreRegisterDetailsModel extends PreRegisterDetails {
  const PreRegisterDetailsModel({
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

  factory PreRegisterDetailsModel.fromJson(Map<String, dynamic> json) =>
      PreRegisterDetailsModel(
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
