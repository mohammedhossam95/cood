import '../../domain/entities/reset_password_response.dart';

class ResetPasswordModel extends ResetPasswordResponse {
  const ResetPasswordModel({
    required super.success,
    required super.message,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      ResetPasswordModel(
        success: json['success'],
        message: json['message'],
      );
}



