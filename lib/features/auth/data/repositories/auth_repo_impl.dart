import 'package:dartz/dartz.dart';

import '/core/base_classes/base_one_response.dart';
import '/features/auth/data/models/delivery_register_model.dart';
import '/features/auth/data/models/new_models/login_model.dart';
import '/features/auth/data/models/new_models/pre_register_model.dart';
import '/features/auth/data/models/new_models/register_model.dart';
import '/features/auth/data/models/new_models/verify_code_model.dart';
import '/features/auth/domain/entities/new_entities/login_response.dart';
import '/features/auth/domain/usecases/delivery_register_use_case.dart';
import '/features/auth/domain/usecases/landery_register_use_case.dart';
import '/features/auth/domain/usecases/new_usecases/new_login_usecase.dart';
import '/features/auth/domain/usecases/new_usecases/pre_register_usecase.dart';
import '/features/auth/domain/usecases/new_usecases/register_usecase.dart';
import '/features/auth/domain/usecases/new_usecases/verify_code_usecase.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/log_utils.dart' as log;
import '../../../../core/utils/values/strings.dart';
import '../../../../injection_container.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../domain/entities/confirm_reset_password_response.dart';
import '../../domain/entities/reset_password_response.dart';
import '../../domain/entities/verify_reset_password_response.dart';
import '../../domain/repositories/auth_repo.dart';
import '../../domain/usecases/confirm_reset_password_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/save_user_role.dart';
import '../../domain/usecases/save_user_type_usecase.dart';
import '../../domain/usecases/user_register_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/verify_reset_password_usecase.dart';
import '../models/login_model.dart';
import '../models/user_register_model.dart';
import '../models/verify_otp_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl({
    required this.remote,
  });

  /// Impl
  @override
  Future<Either<Failure, UserRegisterRespModel>> userRegisterRepo(
      {required UserRegisterParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final UserRegisterRespModel response =
            await remote.userRegister(params: params);

        return Right<Failure, UserRegisterRespModel>(response);
      } on AppException catch (error) {
        log.Log.e(
            '[register] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left<Failure, UserRegisterRespModel>(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, DeliveryRegisterRespModel>> deliveryRegisterRepo(
      {required DeliveryRegisterParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final DeliveryRegisterRespModel responseResp =
            await remote.deliveryRegister(params: params);

        return Right<Failure, DeliveryRegisterRespModel>(responseResp);
      } on AppException catch (error) {
        log.Log.e(
            '[register] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left<Failure, DeliveryRegisterRespModel>(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> landeryRegisterRepo(
      {required LanderyRegisterParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final BaseOneResponse responseResp =
            await remote.landeryRegister(params: params);

        return Right<Failure, BaseOneResponse>(responseResp);
      } on AppException catch (error) {
        log.Log.e(
            '[register] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left<Failure, BaseOneResponse>(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, LoginRespModel>> loginRepo(
      {required LoginParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final LoginRespModel response = await remote.login(params: params);
        sharedPreferences.saveUserId(response.data!.id ?? 0);
        // sharedPreferences.saveUser(response.data ?? const User());
        return Right<Failure, LoginRespModel>(response);
      } on AppException catch (error) {
        log.Log.e(
            '[loginEmail] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left<Failure, LoginRespModel>(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, ConfirmCodeAuthRespModel>> verifyOtpRpo(
      {required VerifyOtpParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final ConfirmCodeAuthRespModel response =
            await remote.verifyOtp(params: params);
        secureStorage.saveAccessToken(response.data!.token);
        return Right<Failure, ConfirmCodeAuthRespModel>(response);
      } on AppException catch (error) {
        log.Log.e(
            '[verifyOtp] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left<Failure, ConfirmCodeAuthRespModel>(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> logout(
      {required LogOutParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final BaseOneResponse response = await remote.logout(params: params);
        await secureStorage.removeDeviceToken();
        return Right<Failure, BaseOneResponse>(response);
      } on AppException catch (error) {
        log.Log.e(
            '[logout] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left<Failure, BaseOneResponse>(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> deleteAccount() async {
    if (await networkInfo.isConnected) {
      try {
        final BaseOneResponse response = await remote.deleteAccount();
        await secureStorage.removeDeviceToken();
        return Right<Failure, BaseOneResponse>(response);
      } on AppException catch (error) {
        log.Log.e(
            '[deleteAccount] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left<Failure, BaseOneResponse>(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, UserType>> getUserType(
      {required NoParams params}) async {
    try {
      UserType userType = sharedPreferences.getUserType();
      return Right<Failure, UserType>(userType);
    } on AppException catch (error) {
      log.Log.e(
          '[getUserType] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left<Failure, UserType>(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveUserType(
      {required SaveUserTypeParams params}) async {
    try {
      bool result = await sharedPreferences.saveUserType(params.type);
      return Right<Failure, bool>(result);
    } on AppException catch (error) {
      log.Log.e(
          '[saveUserType] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left<Failure, bool>(error.toFailure());
    }
  }

// USer Cycle Repo -----------------------------------------------------
  @override
  Future<Either<Failure, bool>> saveUserCycle(
      {required SaveUserCycleParams params}) async {
    try {
      bool result = await sharedPreferences.saveUserCycle(params.type);
      return Right<Failure, bool>(result);
    } on AppException catch (error) {
      log.Log.e(
          '[saveUserRole] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left<Failure, bool>(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, UserCycle>> getUserCycle(
      {required NoParams params}) async {
    try {
      UserCycle userCycle = sharedPreferences.getUserCycle();
      return Right<Failure, UserCycle>(userCycle);
    } on AppException catch (error) {
      log.Log.e(
          '[getUserRole] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left<Failure, UserCycle>(error.toFailure());
    }
  }

  // @override
  // Future<Either<Failure, UpdateRegisterResponse>> updateRegister(
  //     {required UpdateRegisterParams params}) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final UpdateRegisterResponse response =
  //           await remote.updateRegister(params: params);
  //       return Right<Failure, UpdateRegisterResponse>(response);
  //     } on AppException catch (error) {
  //       log.Log.e(
  //           '[updateRegister] [${error.runtimeType.toString()}] ---- ${error.message}');
  //       return Left<Failure, UpdateRegisterResponse>(error.toFailure());
  //     }
  //   } else {
  //     return Left(NetworkFailure(message: Strings.noInternetConnection));
  //   }
  // }

  // @override
  // Future<Either<Failure, VerifyEmailResponse>> verifyEmail(
  //     {required VerifyEmailParams params}) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final VerifyEmailResponse response =
  //           await remote.verifyEmail(params: params);
  //       return Right<Failure, VerifyEmailResponse>(response);
  //     } on AppException catch (error) {
  //       log.Log.e(
  //           '[verifyEmail] [${error.runtimeType.toString()}] ---- ${error.message}');
  //       return Left<Failure, VerifyEmailResponse>(error.toFailure());
  //     }
  //   } else {
  //     return Left(NetworkFailure(message: Strings.noInternetConnection));
  //   }
  // }

  // @override
  // Future<Either<Failure, CheckMobileResponse>> checkMobile(
  //     {required CheckMobileParams params}) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final CheckMobileResponse response =
  //           await remote.checkMobile(params: params);
  //       return Right<Failure, CheckMobileResponse>(response);
  //     } on AppException catch (error) {
  //       log.Log.e(
  //           '[checkMobile] [${error.runtimeType.toString()}] ---- ${error.message}');
  //       return Left<Failure, CheckMobileResponse>(error.toFailure());
  //     }
  //   } else {
  //     return Left(NetworkFailure(message: Strings.noInternetConnection));
  //   }
  // }

  @override
  Future<Either<Failure, VerifyResetPasswordResponse>> verifyResetPassword(
      {required VerifyResetPasswordParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final VerifyResetPasswordResponse response =
            await remote.verifyResetPassword(params: params);
        return Right<Failure, VerifyResetPasswordResponse>(response);
      } on AppException catch (error) {
        log.Log.e(
            '[verifyResetPassword] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left<Failure, VerifyResetPasswordResponse>(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordResponse>> resetPassword(
      {required ResetPasswordParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final ResetPasswordResponse response =
            await remote.resetPassword(params: params);
        return Right<Failure, ResetPasswordResponse>(response);
      } on AppException catch (error) {
        log.Log.e(
            '[resetPassword] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left<Failure, ResetPasswordResponse>(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, ConfirmResetPasswordResponse>> confirmResetPassword(
      {required ConfirmResetPasswordParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final ConfirmResetPasswordResponse response =
            await remote.confirmResetPassword(params: params);
        return Right<Failure, ConfirmResetPasswordResponse>(response);
      } on AppException catch (error) {
        log.Log.e(
            '[confirmResetPassword] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left<Failure, ConfirmResetPasswordResponse>(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel>> newLoginRepo(
      {required NewLoginParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final LoginResponseModel response =
            await remote.newLogin(params: params);
        // sharedPreferences.saveUserId(response.data!.id ?? 0);
        secureStorage.saveAccessToken(response.details!.token);
        sharedPreferences.saveUser(response.details ?? const LoginDetails());

        return Right<Failure, LoginResponseModel>(response);
      } on AppException catch (error) {
        log.Log.e(
            '[loginEmail] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left<Failure, LoginResponseModel>(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, PreRegisterResponseModel>> preRegisterRepo(
      {required PreRegisterParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final PreRegisterResponseModel response =
            await remote.preRegister(params: params);

        return Right<Failure, PreRegisterResponseModel>(response);
      } on AppException catch (error) {
        log.Log.e(
            '[loginEmail] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left<Failure, PreRegisterResponseModel>(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, RegisterResponseModel>> registerRepo(
      {required RegisterParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final RegisterResponseModel response =
            await remote.register(params: params);

        return Right<Failure, RegisterResponseModel>(response);
      } on AppException catch (error) {
        log.Log.e(
            '[register] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left<Failure, RegisterResponseModel>(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, VerifyCodeResponseModel>> verifyCode(
      {required VerifyCodeParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final VerifyCodeResponseModel response =
            await remote.verifyCode(params: params);

        return Right<Failure, VerifyCodeResponseModel>(response);
      } on AppException catch (error) {
        log.Log.e(
            '[loginEmail] [${error.runtimeType.toString()}] ---- ${error.message}');
        return Left<Failure, VerifyCodeResponseModel>(error.toFailure());
      }
    } else {
      return Left(NetworkFailure(message: Strings.noInternetConnection));
    }
  }
}
