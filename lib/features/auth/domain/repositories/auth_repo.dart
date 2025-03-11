import 'package:cood/core/params/auth_params.dart';
import 'package:dartz/dartz.dart';

import '/core/base_classes/base_one_response.dart';
import '/features/auth/data/models/new_models/register_model.dart';
import '/features/auth/data/models/new_models/verify_code_model.dart';
import '/features/auth/data/models/user_register_model.dart';
import '/features/auth/domain/usecases/new_usecases/verify_code_usecase.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/enums.dart';
import '../../data/models/login_model.dart';
import '../../data/models/verify_otp_model.dart';
import '../entities/confirm_reset_password_response.dart';
import '../entities/reset_password_response.dart';
import '../entities/verify_reset_password_response.dart';
import '../usecases/logout_usecase.dart';
import '../usecases/reset_password_usecase.dart';
import '../usecases/save_user_role.dart';
import '../usecases/save_user_type_usecase.dart';
import '../usecases/verify_otp_usecase.dart';
import '../usecases/verify_reset_password_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserRegisterRespModel>> userRegisterRepo(
      {required AuthParams params});

  Future<Either<Failure, RegisterResponseModel>> registerRepo(
      {required AuthParams params});

  Future<Either<Failure, LoginRespModel>> loginRepo(
      {required AuthParams params});

  Future<Either<Failure, VerifyCodeResponseModel>> verifyCode(
      {required VerifyCodeParams params});

  Future<Either<Failure, ConfirmCodeAuthRespModel>> verifyOtpRpo(
      {required VerifyOtpParams params});

  Future<Either<Failure, BaseOneResponse>> logout(
      {required LogOutParams params});

  Future<Either<Failure, BaseOneResponse>> deleteAccount();

  Future<Either<Failure, VerifyResetPasswordResponse>> verifyResetPassword(
      {required VerifyResetPasswordParams params});

  Future<Either<Failure, ResetPasswordResponse>> resetPassword(
      {required ResetPasswordParams params});

  Future<Either<Failure, ConfirmResetPasswordResponse>> confirmResetPassword(
      {required AuthParams params});

  Future<Either<Failure, UserType>> getUserType({
    required NoParams params,
  });

  Future<Either<Failure, bool>> saveUserType({
    required SaveUserTypeParams params,
  });

  Future<Either<Failure, bool>> saveUserCycle({
    required SaveUserCycleParams params,
  });
  Future<Either<Failure, UserCycle>> getUserCycle({
    required NoParams params,
  });
}
