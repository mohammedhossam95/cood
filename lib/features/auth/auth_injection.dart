import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/auth/domain/usecases/new_usecases/verify_code_usecase.dart';
import '/features/auth/presentation/cubit/accept_terms_cubit/accept_terms_cubit.dart';
import '/features/auth/presentation/cubit/user_register_cubit/user_register_cubit.dart';
import '../../injection_container.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'data/repositories/auth_repo_impl.dart';
import 'domain/repositories/auth_repo.dart';
import 'domain/usecases/confirm_reset_password_usecase.dart';
import 'domain/usecases/delete_account_usecase.dart';
import 'domain/usecases/get_user_role_usecase.dart';
import 'domain/usecases/get_user_type_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'domain/usecases/reset_password_usecase.dart';
import 'domain/usecases/save_user_role.dart';
import 'domain/usecases/save_user_type_usecase.dart';
import 'domain/usecases/user_register_usecase.dart';
import 'domain/usecases/verify_otp_usecase.dart';
import 'domain/usecases/verify_reset_password_usecase.dart';
import 'presentation/cubit/auto_login/auto_login_cubit.dart';
import 'presentation/cubit/delete_account/delete_account_cubit.dart';
import 'presentation/cubit/login/login_cubit.dart';
import 'presentation/cubit/logout/logout_cubit.dart';
import 'presentation/cubit/reset_password/reset_password_cubit.dart';
import 'presentation/cubit/verify_otp/verify_otp_cubit.dart';
import 'presentation/cubit/verify_reset_password/verify_reset_password_cubit.dart';

final _sl = ServiceLocator.instance;

Future<void> initAuthFeatureInjection() async {
  ///-> Cubits
  _sl.registerFactory<LoginCubit>(() => LoginCubit(_sl()));
  _sl.registerFactory<UserRegisterCubit>(() => UserRegisterCubit(_sl()));

  _sl.registerFactory<VerifyResetPasswordCubit>(
      () => VerifyResetPasswordCubit(_sl()));
  _sl.registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(_sl()));

  _sl.registerFactory<DeleteAccountCubit>(() => DeleteAccountCubit(_sl()));
  // _sl.registerFactory<UpdateRegisterCubit>(
  //     () => UpdateRegisterCubit(_sl()));

  _sl.registerFactory<UserRegisterCubit>(() => UserRegisterCubit(_sl()));

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

  _sl.registerLazySingleton<LoginEmailUseCase>(
      () => LoginEmailUseCase(repository: _sl()));

  _sl.registerLazySingleton<VerifyCodeUsecase>(
      () => VerifyCodeUsecase(repository: _sl()));

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

  _sl.registerLazySingleton<UserRegisterUseCase>(
      () => UserRegisterUseCase(repository: _sl()));

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

      BlocProvider<LogoutCubit>(
        create: (BuildContext context) => _sl<LogoutCubit>(),
      ),
      // BlocProvider<UpdateRegisterCubit>(
      //   create: (BuildContext context) => _sl<UpdateRegisterCubit>(),
      // ),

      BlocProvider<VerifyOtpCubit>(
        create: (BuildContext context) => _sl<VerifyOtpCubit>(),
      ),
      BlocProvider<AutoLoginCubit>(
        create: (BuildContext context) => _sl<AutoLoginCubit>(),
      ),
    ];
