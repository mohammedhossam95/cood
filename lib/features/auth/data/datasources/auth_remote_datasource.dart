import 'package:cood/core/params/auth_params.dart';
import 'package:dio/dio.dart';

import '/features/auth/data/models/new_models/verify_code_model.dart';
import '/features/auth/data/models/verify_otp_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../models/confirm_reset_password_model.dart';
import '../models/login_model.dart';
import '../models/reset_password_model.dart';
import '../models/user_register_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginRespModel> login({required AuthParams params});
  Future<UserRegisterRespModel> doRemoteRegister({required AuthParams params});
  Future<VerifyCodeResponseModel> verifyRemoteCode(
      {required AuthParams params});

  Future<ConfirmCodeAuthRespModel> sendRemoteCode({required AuthParams params});

  Future<ResetPasswordModel> resetPassword(
      {required ResetPasswordParams params});
  Future<ConfirmResetPasswordModel> confirmResetPassword(
      {required AuthParams params});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserRegisterRespModel> doRemoteRegister(
      {required AuthParams params}) async {
    try {
      final dynamic response = await dioConsumer.post(
        '/auth/register',
        formData: FormData.fromMap({
          "name": params.name,
          'phone': params.phone,
          'password': params.password,
          'password_confirmation': params.passwordConfirm,
        }),
      );
      if (response["status"] == 'success') {
        return UserRegisterRespModel.fromJson(response);
      }

      throw ServerException(message: response['message'] ?? '');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<LoginRespModel> login({required AuthParams params}) async {
    try {
      final dynamic response = await dioConsumer.post(
        '/auth/login',
        body: params.toJson(),
      );
      if (response['status'] == 'success') {
        return LoginRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ResetPasswordModel> resetPassword({
    required ResetPasswordParams params,
  }) async {
    try {
      const String resetPasswordEndpoint = '/auth/reset/password';
      final dynamic response = await dioConsumer.post(
        resetPasswordEndpoint,
        body: params.toJson(),
      );

      if (response['key'] == "success") {
        return ResetPasswordModel.fromJson(response);
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ConfirmResetPasswordModel> confirmResetPassword(
      {required AuthParams params}) async {
    try {
      const String confirmResetPasswordEndpoint = '/auth/reset/confirmation';
      final dynamic response = await dioConsumer.post(
        confirmResetPasswordEndpoint,
        body: params.toJson(),
      );

      if (response['key'] == "success") {
        return ConfirmResetPasswordModel.fromJson(response);
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ConfirmCodeAuthRespModel> sendRemoteCode(
      {required AuthParams params}) {
    throw UnimplementedError();
  }

  @override
  Future<VerifyCodeResponseModel> verifyRemoteCode(
      {required AuthParams params}) async {
    try {
      final dynamic response = await dioConsumer.post(
        '/auth/verify-otp',
        body: {
          "user_id": params.userId,
          "otp": params.otp,
        },
      );
      if (response['status'] == 'success') {
        return VerifyCodeResponseModel.fromJson(response);
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (error) {
      rethrow;
    }
  }
}
