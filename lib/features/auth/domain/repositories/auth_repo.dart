import 'package:dartz/dartz.dart';

import '/core/base_classes/base_one_response.dart';
import '/features/auth/data/models/new_models/login_model.dart';
import '/features/auth/data/models/new_models/pre_register_model.dart';
import '/features/auth/data/models/new_models/register_model.dart';
import '/features/auth/data/models/new_models/verify_code_model.dart';
import '/features/auth/data/models/user_register_model.dart';
import '/features/auth/domain/usecases/new_usecases/new_login_usecase.dart';
import '/features/auth/domain/usecases/new_usecases/pre_register_usecase.dart';
import '/features/auth/domain/usecases/new_usecases/register_usecase.dart';
import '/features/auth/domain/usecases/new_usecases/verify_code_usecase.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/enums.dart';
import '../../data/models/delivery_register_model.dart';
import '../../data/models/login_model.dart';
import '../../data/models/verify_otp_model.dart';
import '../../domain/entities/confirm_reset_password_response.dart';
import '../../domain/entities/reset_password_response.dart';
import '../../domain/entities/verify_reset_password_response.dart';
import '../../domain/usecases/confirm_reset_password_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/verify_reset_password_usecase.dart';
import '../usecases/delivery_register_use_case.dart';
import '../usecases/landery_register_use_case.dart';
import '../usecases/login_usecase.dart';
import '../usecases/logout_usecase.dart';
import '../usecases/save_user_role.dart';
import '../usecases/save_user_type_usecase.dart';
import '../usecases/user_register_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserRegisterRespModel>> userRegisterRepo({
    required UserRegisterParams params,
  });

  Future<Either<Failure, DeliveryRegisterRespModel>> deliveryRegisterRepo({
    required DeliveryRegisterParams params,
  });

  Future<Either<Failure, BaseOneResponse>> landeryRegisterRepo({
    required LanderyRegisterParams params,
  });
  Future<Either<Failure, RegisterResponseModel>> registerRepo({
    required RegisterParams params,
  });

  Future<Either<Failure, LoginRespModel>> loginRepo({
    required LoginParams params,
  });
  Future<Either<Failure, LoginResponseModel>> newLoginRepo({
    required NewLoginParams params,
  });

  Future<Either<Failure, PreRegisterResponseModel>> preRegisterRepo({
    required PreRegisterParams params,
  });
  Future<Either<Failure, VerifyCodeResponseModel>> verifyCode({
    required VerifyCodeParams params,
  });

  Future<Either<Failure, ConfirmCodeAuthRespModel>> verifyOtpRpo({
    required VerifyOtpParams params,
  });

  Future<Either<Failure, BaseOneResponse>> logout({
    required LogOutParams params,
  });

  Future<Either<Failure, BaseOneResponse>> deleteAccount();

  Future<Either<Failure, VerifyResetPasswordResponse>> verifyResetPassword({
    required VerifyResetPasswordParams params,
  });

  Future<Either<Failure, ResetPasswordResponse>> resetPassword({
    required ResetPasswordParams params,
  });

  Future<Either<Failure, ConfirmResetPasswordResponse>> confirmResetPassword({
    required ConfirmResetPasswordParams params,
  });

  // Future<Either<Failure, UpdateRegisterResponse>> updateRegister({
  //   required UpdateRegisterParams params,
  // });

  // Future<Either<Failure, VerifyEmailResponse>> verifyEmail({
  //   required VerifyEmailParams params,
  // });

  // Future<Either<Failure, CheckMobileResponse>> checkMobile({
  //   required CheckMobileParams params,
  // });

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
