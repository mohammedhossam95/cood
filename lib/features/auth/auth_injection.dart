import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/auth/domain/usecases/new_usecases/new_login_usecase.dart';
import '/features/auth/domain/usecases/new_usecases/pre_register_usecase.dart';
import '/features/auth/domain/usecases/new_usecases/register_usecase.dart';
import '/features/auth/domain/usecases/new_usecases/verify_code_usecase.dart';
import '/features/auth/presentation/cubit/accept_terms_cubit/accept_terms_cubit.dart';
import '/features/auth/presentation/cubit/delivery_register_cubit/delivery_register_cubit.dart';
import '/features/auth/presentation/cubit/guest_login/guest_login_cubit.dart';
import '/features/auth/presentation/cubit/new_cubit/new_login/new_login_cubit.dart';
import '/features/auth/presentation/cubit/new_cubit/pre_register/pre_register_cubit.dart';
import '/features/auth/presentation/cubit/new_cubit/register/register_cubit.dart';
import '/features/auth/presentation/cubit/new_cubit/verify_code/verify_code_cubit.dart';
import '/features/auth/presentation/cubit/user_register_cubit/user_register_cubit.dart';
import '../../injection_container.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'data/repositories/auth_repo_impl.dart';
import 'domain/repositories/auth_repo.dart';
import 'domain/usecases/confirm_reset_password_usecase.dart';
import 'domain/usecases/delete_account_usecase.dart';
import 'domain/usecases/delivery_register_use_case.dart';
import 'domain/usecases/get_user_role_usecase.dart';
import 'domain/usecases/get_user_type_usecase.dart';
import 'domain/usecases/landery_register_use_case.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'domain/usecases/reset_password_usecase.dart';
import 'domain/usecases/save_user_role.dart';
import 'domain/usecases/save_user_type_usecase.dart';
import 'domain/usecases/user_register_usecase.dart';
import 'domain/usecases/verify_otp_usecase.dart';
import 'domain/usecases/verify_reset_password_usecase.dart';
import 'presentation/cubit/auto_login/auto_login_cubit.dart';
import 'presentation/cubit/confirm_reset_password/confirm_reset_password_cubit.dart';
import 'presentation/cubit/delete_account/delete_account_cubit.dart';
import 'presentation/cubit/landery_register_cubit/landery_register_cubit.dart';
import 'presentation/cubit/login/login_cubit.dart';
import 'presentation/cubit/logout/logout_cubit.dart';
import 'presentation/cubit/reset_password/reset_password_cubit.dart';
import 'presentation/cubit/verify_otp/verify_otp_cubit.dart';
import 'presentation/cubit/verify_reset_password/verify_reset_password_cubit.dart';

final _sl = ServiceLocator.instance;

Future<void> initAuthFeatureInjection() async {
  ///-> Cubits
  _sl.registerFactory<ConfirmResetPasswordCubit>(
      () => ConfirmResetPasswordCubit(_sl()));
  _sl.registerFactory<VerifyResetPasswordCubit>(
      () => VerifyResetPasswordCubit(_sl()));
  _sl.registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(_sl()));

  _sl.registerFactory<DeleteAccountCubit>(() => DeleteAccountCubit(_sl()));
  // _sl.registerFactory<UpdateRegisterCubit>(
  //     () => UpdateRegisterCubit(_sl()));
  //Amr Injection Cubit ------------------------------
  _sl.registerFactory<DeliveryRegisterCubit>(
      () => DeliveryRegisterCubit(deliveryRegisterUseCase: _sl()));
  _sl.registerFactory<UserRegisterCubit>(() => UserRegisterCubit(_sl()));
  _sl.registerFactory<LanderyRegisterCubit>(
      () => LanderyRegisterCubit(landeryRegisterUseCase: _sl()));
  //Amr Injection Cubit ------------------------------

  _sl.registerFactory<LoginCubit>(() => LoginCubit(_sl()));

  // Ali Injection Cubit
  _sl.registerFactory<NewLoginCubit>(() => NewLoginCubit(_sl()));
  _sl.registerFactory<RegisterCubit>(() => RegisterCubit(_sl()));
  _sl.registerFactory<PreRegisterCubit>(() => PreRegisterCubit(_sl()));
  _sl.registerFactory<VerifyCodeCubit>(() => VerifyCodeCubit(_sl()));

  _sl.registerFactory<GuestLoginCubit>(() => GuestLoginCubit(_sl()));
  // _sl.registerFactory<VerifyEmailCubit>(() => VerifyEmailCubit(_sl()));
  // _sl.registerFactory<CheckMobileCubit>(() => CheckMobileCubit(_sl()));
  _sl.registerFactory<VerifyOtpCubit>(() => VerifyOtpCubit(_sl()));
  _sl.registerFactory<AutoLoginCubit>(() => AutoLoginCubit(
        getUserTypeUseCase: _sl(),
        saveUserTypeUseCase: _sl(),
        getUserCycleUseCase: _sl(),
        saveUserCycleUseCase: _sl(),
      ));
  _sl.registerFactory<LogoutCubit>(() => LogoutCubit(logoutUseCase: _sl()));
  _sl.registerFactory<AcceptTermsCubit>(() => AcceptTermsCubit());

  ///-> UseCases
  _sl.registerLazySingleton<ConfirmResetPasswordUseCase>(
      () => ConfirmResetPasswordUseCase(repository: _sl()));
  _sl.registerLazySingleton<VerifyResetPasswordUseCase>(
      () => VerifyResetPasswordUseCase(repository: _sl()));
  _sl.registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(repository: _sl()));
  _sl.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(repository: _sl()));
  _sl.registerLazySingleton<DeleteAccountUseCase>(
      () => DeleteAccountUseCase(repository: _sl()));
  // _sl.registerLazySingleton<UpdateRegisterUseCase>(
  //     () => UpdateRegisterUseCase(repository: _sl()));

  // Ali Inject UseCases
  _sl.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(authRepository: _sl()));

  _sl.registerLazySingleton<NewLoginUsecase>(
      () => NewLoginUsecase(repository: _sl()));

  _sl.registerLazySingleton<VerifyCodeUsecase>(
      () => VerifyCodeUsecase(repository: _sl()));

  _sl.registerLazySingleton<PreRegisterUsecase>(
      () => PreRegisterUsecase(repository: _sl()));

  //Amr Injection Use Case ------------------------------
  _sl.registerLazySingleton<LoginEmailUseCase>(
      () => LoginEmailUseCase(repository: _sl()));
  // _sl.registerLazySingleton<VerifyEmailUseCase>(
  //     () => VerifyEmailUseCase(repository: _sl()));
  // _sl.registerLazySingleton<CheckMobileUseCase>(
  //     () => CheckMobileUseCase(repository: _sl()));
  _sl.registerLazySingleton<VerifyOtpUseCase>(
      () => VerifyOtpUseCase(repository: _sl()));
  _sl.registerLazySingleton<GetUserTypeUseCase>(
      () => GetUserTypeUseCase(repository: _sl()));
  _sl.registerLazySingleton<GetUserCycleUseCase>(
      () => GetUserCycleUseCase(repository: _sl()));
  _sl.registerLazySingleton<SaveUserTypeUseCase>(
      () => SaveUserTypeUseCase(repository: _sl()));
  _sl.registerLazySingleton<SaveUserCycleUseCase>(
      () => SaveUserCycleUseCase(repository: _sl()));
  _sl.registerLazySingleton<DeliveryRegisterUseCase>(
      () => DeliveryRegisterUseCase(authRepository: _sl()));
  _sl.registerLazySingleton<UserRegisterUseCase>(
      () => UserRegisterUseCase(repository: _sl()));
  _sl.registerLazySingleton<LanderyRegisterUseCase>(
      () => LanderyRegisterUseCase(authRepository: _sl()));

  ///-> Repository
  _sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remote: _sl()));

  ///-> DataSource
  _sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
}

///-> BlocProvider
List<BlocProvider> get authBlocs => <BlocProvider>[
      BlocProvider<DeleteAccountCubit>(
        create: (BuildContext context) => _sl<DeleteAccountCubit>(),
      ),
      BlocProvider<VerifyResetPasswordCubit>(
        create: (BuildContext context) => _sl<VerifyResetPasswordCubit>(),
      ),
      BlocProvider<ResetPasswordCubit>(
        create: (BuildContext context) => _sl<ResetPasswordCubit>(),
      ),
      BlocProvider<ConfirmResetPasswordCubit>(
        create: (BuildContext context) => _sl<ConfirmResetPasswordCubit>(),
      ),
      BlocProvider<LogoutCubit>(
        create: (BuildContext context) => _sl<LogoutCubit>(),
      ),
      // BlocProvider<UpdateRegisterCubit>(
      //   create: (BuildContext context) => _sl<UpdateRegisterCubit>(),
      // ),
      BlocProvider<UserRegisterCubit>(
        create: (BuildContext context) => _sl<UserRegisterCubit>(),
      ),
      BlocProvider<DeliveryRegisterCubit>(
        create: (BuildContext context) => _sl<DeliveryRegisterCubit>(),
      ),
      BlocProvider<LoginCubit>(
        create: (BuildContext context) => _sl<LoginCubit>(),
      ),
      BlocProvider<GuestLoginCubit>(
        create: (BuildContext context) => _sl<GuestLoginCubit>(),
      ),
      BlocProvider<LanderyRegisterCubit>(
        create: (BuildContext context) => _sl<LanderyRegisterCubit>(),
      ),
      // BlocProvider<VerifyEmailCubit>(
      //   create: (BuildContext context) => _sl<VerifyEmailCubit>(),
      // ),
      // BlocProvider<CheckMobileCubit>(
      //   create: (BuildContext context) => _sl<CheckMobileCubit>(),
      // ),
      BlocProvider<VerifyOtpCubit>(
        create: (BuildContext context) => _sl<VerifyOtpCubit>(),
      ),
      BlocProvider<AutoLoginCubit>(
        create: (BuildContext context) => _sl<AutoLoginCubit>(),
      ),

      BlocProvider<NewLoginCubit>(
        create: (BuildContext context) => _sl<NewLoginCubit>(),
      ),
      BlocProvider<RegisterCubit>(
        create: (BuildContext context) => _sl<RegisterCubit>(),
      ),
      BlocProvider<VerifyCodeCubit>(
        create: (BuildContext context) => _sl<VerifyCodeCubit>(),
      ),
      BlocProvider<PreRegisterCubit>(
        create: (BuildContext context) => _sl<PreRegisterCubit>(),
      ),
    ];
