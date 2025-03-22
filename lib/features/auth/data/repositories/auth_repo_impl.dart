import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/core/params/auth_params.dart';
import 'package:cood/features/auth/data/models/new_models/register_model.dart';
import 'package:cood/features/auth/domain/entities/login_response.dart';
import 'package:cood/features/auth/domain/usecases/logout_usecase.dart';
import 'package:dartz/dartz.dart';

import '/features/auth/data/models/new_models/verify_code_model.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/log_utils.dart' as log;
import '../../../../injection_container.dart';
import '../../domain/entities/confirm_reset_password_response.dart';
import '../../domain/entities/reset_password_response.dart';
import '../../domain/entities/verify_reset_password_response.dart';
import '../../domain/repositories/auth_repo.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/save_user_role.dart';
import '../../domain/usecases/save_user_type_usecase.dart';
import '../../domain/usecases/verify_reset_password_usecase.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_model.dart';
import '../models/user_register_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl({required this.remote});

  /// Impl
  @override
  Future<Either<Failure, UserRegisterRespModel>> userRegisterRepo(
      {required AuthParams params}) async {
    try {
      final UserRegisterRespModel response =
          await remote.doRemoteRegister(params: params);

      return Right<Failure, UserRegisterRespModel>(response);
    } on AppException catch (error) {
      log.Log.e(
          '[register] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left<Failure, UserRegisterRespModel>(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> verifyOtpRpo(
      {required AuthParams params}) async {
    try {
      final response = await remote.verifyRemoteCode(params: params);
      secureStorage.saveAccessToken("");
      log.Log.e(response.toString());
      return Right<Failure, BaseOneResponse>(response);
    } on AppException catch (error) {
      log.Log.e(
          '[verifyOtp] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left<Failure, BaseOneResponse>(error.toFailure());
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

  @override
  Future<Either<Failure, VerifyResetPasswordResponse>> verifyResetPassword(
      {required VerifyResetPasswordParams params}) async {
    try {
      final VerifyResetPasswordResponse response =
          VerifyResetPasswordResponse(success: true, message: "");
      return Right<Failure, VerifyResetPasswordResponse>(response);
    } on AppException catch (error) {
      log.Log.e(
          '[verifyResetPassword] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left<Failure, VerifyResetPasswordResponse>(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, ResetPasswordResponse>> resetPassword(
      {required ResetPasswordParams params}) async {
    try {
      final ResetPasswordResponse response =
          await remote.resetPassword(params: params);
      return Right<Failure, ResetPasswordResponse>(response);
    } on AppException catch (error) {
      log.Log.e(
          '[resetPassword] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left<Failure, ResetPasswordResponse>(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, ConfirmResetPasswordResponse>> confirmResetPassword(
      {required AuthParams params}) async {
    try {
      final ConfirmResetPasswordResponse response =
          await remote.confirmResetPassword(params: params);
      return Right<Failure, ConfirmResetPasswordResponse>(response);
    } on AppException catch (error) {
      log.Log.e(
          '[confirmResetPassword] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left<Failure, ConfirmResetPasswordResponse>(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, LoginRespModel>> loginRepo(
      {required AuthParams params}) async {
    try {
      final LoginRespModel response = await remote.login(params: params);
      sharedPreferences.saveUserId(response.result?.user?.id ?? 0);
      sharedPreferences.saveUser(response.result?.user ?? const User());
      secureStorage.saveAccessToken(response.result?.token);

      return Right<Failure, LoginRespModel>(response);
    } on AppException catch (error) {
      log.Log.e(
          '[loginEmail] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left<Failure, LoginRespModel>(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, VerifyCodeResponseModel>> verifyCode(
      {required AuthParams params}) async {
    try {
      final VerifyCodeResponseModel response =
          await remote.verifyRemoteCode(params: params);

      return Right<Failure, VerifyCodeResponseModel>(response);
    } on AppException catch (error) {
      log.Log.e(
          '[loginEmail] [${error.runtimeType.toString()}] ---- ${error.message}');
      return Left<Failure, VerifyCodeResponseModel>(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, BaseOneResponse>> deleteAccount() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, BaseOneResponse>> logout(
      {required LogOutParams params}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RegisterResponseModel>> registerRepo(
      {required AuthParams params}) {
    throw UnimplementedError();
  }
}
