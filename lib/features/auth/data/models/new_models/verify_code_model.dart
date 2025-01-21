// To parse this JSON data, do
//
//     final verifyCodeResponse = verifyCodeResponseFromJson(jsonString);

import 'dart:convert';

import '/features/auth/domain/entities/new_entities/verify_code_response.dart';

VerifyCodeResponse verifyCodeResponseFromJson(String str) =>
    VerifyCodeResponseModel.fromJson(json.decode(str));

String verifyCodeResponseToJson(VerifyCodeResponseModel data) =>
    json.encode(data.toJson());

class VerifyCodeResponseModel extends VerifyCodeResponse {
  const VerifyCodeResponseModel({
    super.message,
    super.statusCode,
    super.time,
    super.details,
  });

  factory VerifyCodeResponseModel.fromJson(Map<String, dynamic> json) =>
      VerifyCodeResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        time: json["time"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "time": time,
        "details": details,
      };
}
