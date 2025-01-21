import 'package:dio/dio.dart';

import '/features/auth/data/models/delivery_register_model.dart';
import '/features/auth/data/models/new_models/login_model.dart';
import '/features/auth/data/models/new_models/pre_register_model.dart';
import '/features/auth/data/models/new_models/register_model.dart';
import '/features/auth/data/models/new_models/verify_code_model.dart';
import '/features/auth/data/models/verify_otp_model.dart';
import '/features/auth/domain/usecases/new_usecases/new_login_usecase.dart';
import '/features/auth/domain/usecases/new_usecases/pre_register_usecase.dart';
import '/features/auth/domain/usecases/new_usecases/register_usecase.dart';
import '/features/auth/domain/usecases/new_usecases/verify_code_usecase.dart';
import '../../../../core/api/dio_consumer.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/confirm_reset_password_usecase.dart';
import '../../domain/usecases/delivery_register_use_case.dart';
import '../../domain/usecases/landery_register_use_case.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/user_register_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/verify_reset_password_usecase.dart';
import '../models/confirm_reset_password_model.dart';
import '../models/delete_account_model.dart';
import '../models/landery_register_model.dart';
import '../models/login_model.dart';
import '../models/logout_model.dart';
import '../models/reset_password_model.dart';
import '../models/user_register_model.dart';
import '../models/verify_reset_password_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserRegisterRespModel> userRegister({
    required UserRegisterParams params,
  });
  Future<DeliveryRegisterRespModel> deliveryRegister(
      {required DeliveryRegisterParams params});

  Future<LanderyRegisterRespModel> landeryRegister(
      {required LanderyRegisterParams params});

  Future<LoginRespModel> login({required LoginParams params});

  Future<LoginResponseModel> newLogin({required NewLoginParams params});
  Future<PreRegisterResponseModel> preRegister(
      {required PreRegisterParams params});
  Future<RegisterResponseModel> register({required RegisterParams params});
  Future<VerifyCodeResponseModel> verifyCode(
      {required VerifyCodeParams params});

  Future<ConfirmCodeAuthRespModel> verifyOtp({required VerifyOtpParams params});

  Future<LogOutRespModel> logout({required LogOutParams params});
  Future<DeleteMyAccountRespModel> deleteAccount();

  Future<VerifyResetPasswordModel> verifyResetPassword({
    required VerifyResetPasswordParams params,
  });

  Future<ResetPasswordModel> resetPassword({
    required ResetPasswordParams params,
  });

  Future<ConfirmResetPasswordModel> confirmResetPassword({
    required ConfirmResetPasswordParams params,
  });

  // Future<UpdateRegisterModel> updateRegister({
  //   required UpdateRegisterParams params,
  // });

  // Future<VerifyEmailModel> verifyEmail({
  //   required VerifyEmailParams params,
  // });

  // Future<CheckMobileModel> checkMobile({
  //   required CheckMobileParams params,
  // });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<DeliveryRegisterRespModel> deliveryRegister(
      {required DeliveryRegisterParams params}) async {
    try {
      String? deviceId = await Constants.getDeviceId();
      String? deviceType = await Constants.getModel();
      var formData = FormData();

      if (params.name != null) {
        formData.fields.add(MapEntry('name', params.name ?? ''));
      }
      if (params.phone != null) {
        formData.fields.add(MapEntry('phone', params.phone ?? '00000000000'));
      }
      if (params.avatar != null) {
        formData.files.add(MapEntry(
            'avatar',
            await MultipartFile.fromFile(params.avatar!.path,
                filename: params.avatar?.path.split('/').last)));
      }
      if (params.address != null) {
        formData.fields.add(MapEntry('address', params.address ?? ''));
      }
      if (params.latitude != null) {
        formData.fields.add(MapEntry('lat', params.latitude ?? '00000000000'));
      }
      if (params.longitude != null) {
        formData.fields.add(MapEntry('lng', params.longitude ?? '00000000000'));
      }
      if (params.carNumber != null) {
        formData.fields.add(MapEntry('car_number', params.carNumber ?? ''));
      }
      if (params.drivingLicense != null) {
        formData.files.add(MapEntry(
            'driving_license',
            await MultipartFile.fromFile(
              params.drivingLicense!.path,
              filename: params.drivingLicense?.path.split('/').last,
            )));
      }
      if (params.idNumber != null) {
        formData.files.add(MapEntry(
            'id_number',
            await MultipartFile.fromFile(
              params.idNumber!.path,
              filename: params.idNumber?.path.split('/').last,
            )));
      }
      if (deviceId!.isNotEmpty) {
        formData.fields.add(MapEntry(
          'device_id',
          deviceId,
        ));
      }
      if (deviceType.isNotEmpty) {
        formData.fields.add(MapEntry(
          'device_type',
          deviceType,
        ));
      }
      if (params.password != null) {
        formData.fields.add(MapEntry(
          'password',
          params.password ?? '',
        ));
      }
      var response = await dioConsumer.post(
        '/api/sign-up-delegate',
        formData: formData,
      );
      if (response['key'] == 'success') {
        return DeliveryRegisterRespModel.fromJson(response);
      } else if (response["msg"] != null) {
        throw ServerException(message: response['msg'] ?? '');
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserRegisterRespModel> userRegister({
    required UserRegisterParams params,
  }) async {
    try {
      String? deviceId = await Constants.getDeviceId();
      String? deviceType = await Constants.getModel();
      final dynamic response = await dioConsumer.post(
        '/api/sign-up-user',
        formData: FormData.fromMap({
          'name': params.firstName,
          'phone': params.mobile,
          'address': params.address,
          'lat': params.latitude,
          'lng': params.longitude,
          'device_id': deviceId,
          'device_type': deviceType,
          // 'password':params.password,
          // 'device_id': Constants.getDeviceId(),
          // 'device_type': Constants.getModel(),
          // 'password': params.password,
          'avatar': await MultipartFile.fromFile(params.avatar!.path,
              filename: params.avatar?.path.split('/').last),
        }),
        body: params.toJson(),
      );
      if (response["key"] == 'success') {
        return UserRegisterRespModel.fromJson(response);
      } else if (response["msg"] != null) {
        throw ServerException(message: response['msg'] ?? '');
      }

      throw ServerException(message: response['message'] ?? '');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<LanderyRegisterRespModel> landeryRegister(
      {required LanderyRegisterParams params}) async {
    try {
      String? deviceId = await Constants.getDeviceId();
      String? deviceType = await Constants.getModel();
      var formData = FormData();

      if (params.userName != null) {
        formData.fields.add(MapEntry(
          'name',
          params.userName ?? '',
        ));
      }
      if (params.phone != null) {
        formData.fields.add(MapEntry('phone', params.phone ?? '00000000000'));
      }

      if (params.email != null) {
        formData.fields.add(MapEntry('email', params.email ?? ''));
      }
      if (params.descreptionAR != null) {
        formData.fields.add(MapEntry('desc_ar', params.descreptionAR ?? ''));
      }
      if (params.descreptionEN != null) {
        formData.fields.add(MapEntry('desc_en', params.descreptionEN ?? ''));
      }
      if (params.commerical != null) {
        formData.fields.add(MapEntry('commercial', params.commerical ?? ''));
      }
      if (params.daysWork != null) {
        formData.fields.add(MapEntry('days', params.daysWork ?? ''));
      }
      if (params.timeFrom != null) {
        formData.fields.add(MapEntry('time_from', params.timeFrom ?? ''));
      }
      if (params.timeTo != null) {
        formData.fields.add(MapEntry('time_to', params.timeTo ?? ''));
      }
      if (params.address != null) {
        formData.fields.add(MapEntry('address', params.address ?? ''));
      }
      if (params.latitude != null) {
        formData.fields.add(MapEntry('lat', params.latitude ?? '00000000000'));
      }
      if (params.longitude != null) {
        formData.fields.add(MapEntry('lng', params.longitude ?? '00000000000'));
      }
      if (deviceId!.isNotEmpty) {
        formData.fields.add(MapEntry(
          'device_id',
          deviceId,
        ));
      }
      if (deviceType.isNotEmpty) {
        formData.fields.add(MapEntry(
          'device_type',
          deviceType,
        ));
      }
      if (params.file != null) {
        formData.files.add(MapEntry(
            'file',
            await MultipartFile.fromFile(params.file!.path,
                filename: params.file?.path.split('/').last)));
      }
      var response = await dioConsumer.post(
        '/api/sign-up-provider',
        formData: formData,
      );
      if (response['key'] == 'success') {
        return LanderyRegisterRespModel.fromJson(response);
      } else if (response["msg"] != null) {
        throw ServerException(message: response['msg'] ?? '');
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginRespModel> login({required LoginParams params}) async {
    try {
      final dynamic response = await dioConsumer.post(
        '/api/sign-in',
        body: params.toJson(),
      );
      if (response['key'] == 'success') {
        return LoginRespModel.fromJson(response);
      } else if (response["msg"] != null) {
        throw ServerException(message: response['msg'] ?? '');
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ConfirmCodeAuthRespModel> verifyOtp({
    required VerifyOtpParams params,
  }) async {
    try {
      final dynamic response = await dioConsumer.post(
        '/api/confirmSignIn',
        body: params.toJson(),
      );

      if (response['key'] == 'success') {
        return ConfirmCodeAuthRespModel.fromJson(response);
      } else if (response["msg"] != null) {
        throw ServerException(message: response['msg'] ?? '');
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<LogOutRespModel> logout({required LogOutParams params}) async {
    try {
      final dynamic response = await dioConsumer.post(
        '/api/log-out',
        body: params.toJson(),
      );

      if (response['key'] == 'success') {
        return LogOutRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<DeleteMyAccountRespModel> deleteAccount() async {
    try {
      final dynamic response = await dioConsumer.delete(
        '/api/deleteMyAccount',
      );

      if (response['key'] == 'success') {
        return DeleteMyAccountRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<VerifyResetPasswordModel> verifyResetPassword({
    required VerifyResetPasswordParams params,
  }) async {
    try {
      const String verifyResetPasswordEndpoint =
          '/${ApiConstants.doctors}/${ApiConstants.version}/auth/reset/verify';
      final dynamic response = await dioConsumer.post(
        verifyResetPasswordEndpoint,
        body: params.toJson(),
      );

      if (response['key'] == "success") {
        return VerifyResetPasswordModel.fromJson(response);
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
      const String resetPasswordEndpoint =
          '/${ApiConstants.doctors}/${ApiConstants.version}/auth/reset/password';
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
  Future<ConfirmResetPasswordModel> confirmResetPassword({
    required ConfirmResetPasswordParams params,
  }) async {
    try {
      const String confirmResetPasswordEndpoint =
          '/${ApiConstants.doctors}/${ApiConstants.version}/auth/reset/confirmation';
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
  Future<LoginResponseModel> newLogin({required NewLoginParams params}) async {
    try {
      final dynamic response = await dioConsumer.post(
        '/auth/login',
        body: params.toJson(),
      );

      if (response['status_code'] == 200) {
        return LoginResponseModel.fromJson(response);
      } else if (response["message"] != null) {
        // throw ServerException(message: response['message'] ?? '');
        throw ServerException(message: response['details'] ?? '');
      }
      throw ServerException(message: response['details'] ?? '');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<PreRegisterResponseModel> preRegister(
      {required PreRegisterParams params}) async {
    try {
      final dynamic response = await dioConsumer.post(
        '/auth/pre_register',
        body: params.toJson(),
      );
      if (response['status_code'] == 200) {
        return PreRegisterResponseModel.fromJson(response);
      } else if (response["message"] != null) {
        // throw ServerException(message: response['message'] ?? '');
        throw ServerException(message: response['details'][0] ?? '');
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<RegisterResponseModel> register(
      {required RegisterParams params}) async {
    try {
      final dynamic response = await dioConsumer.post(
        '/auth/register/${params.userCode}',
        formData: FormData.fromMap({
          'username': params.username,
          'email': params.email,
          'password': params.password,
          'identification': await MultipartFile.fromFile(
              params.identification!.path,
              filename: params.identification?.path.split('/').last),
          'drivingLicence': await MultipartFile.fromFile(
              params.drivingLicence!.path,
              filename: params.drivingLicence?.path.split('/').last),
        }),
        body: params.toJson(),
      );
      if (response["status_code"] == 200) {
        return RegisterResponseModel.fromJson(response);
      } else if (response["message"] != null) {
        throw ServerException(message: response['details'][0] ?? '');
      }

      throw ServerException(message: response['message'] ?? '');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<VerifyCodeResponseModel> verifyCode(
      {required VerifyCodeParams params}) async {
    try {
      final dynamic response = await dioConsumer.post(
        '/auth/verify/${params.userCode}/${params.otp}',
        body: params.toJson(),
      );
      if (response['status_code'] == 200) {
        return VerifyCodeResponseModel.fromJson(response);
      } else if (response["message"] != null) {
        // throw ServerException(message: response['message'] ?? '');
        throw ServerException(message: response['details'][0] ?? '');
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (error) {
      rethrow;
    }
  }
  // @override
  // Future<UpdateRegisterModel> updateRegister({
  //   required UpdateRegisterParams params,
  // }) async {
  //   try {
  //     const String updateRegisterEndpoint =
  //         '/${ApiConstants.doctors}/${ApiConstants.version}/auth/register/update';
  //     final dynamic response = await dioConsumer.post(
  //       updateRegisterEndpoint,
  //       formData: await params.toJson(),
  //     );
  //     if (response['key'] == "success") {
  //       return UpdateRegisterModel.fromJson(response);
  //     }
  //     throw ServerException(message: response['message'] ?? '');
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<VerifyEmailModel> verifyEmail({
  //   required VerifyEmailParams params,
  // }) async {
  //   try {
  //     const String verifyEmailEndpoint =
  //         '/${ApiConstants.doctors}/${ApiConstants.version}/auth/verify/email';
  //     final dynamic response = await dioConsumer.post(
  //       verifyEmailEndpoint,
  //       body: params.toJson(),
  //     );
  //     if (response['key'] == "success") {
  //       return VerifyEmailModel.fromJson(response);
  //     }
  //     throw ServerException(message: response['message'] ?? '');
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<CheckMobileModel> checkMobile({
  //   required CheckMobileParams params,
  // }) async {
  //   try {
  //     const String checkMobileEndpoint =
  //         '/${ApiConstants.doctors}/${ApiConstants.version}/auth/check/mobile';
  //     final dynamic response = await dioConsumer.post(
  //       checkMobileEndpoint,
  //       body: params.toJson(),
  //     );
  //     if (response['key'] == "success") {
  //       return CheckMobileModel.fromJson(response);
  //     }
  //     throw ServerException(message: response['message'] ?? '');
  //   } catch (error) {
  //     rethrow;
  //   }
  // }
}
