import 'package:cood/features/categories/data/datasource/categories_remote_datesource.dart';
import 'package:cood/features/categories/data/repositry_imple/categories_repositry_impl.dart';
import 'package:cood/features/categories/domain/repository/categories_repository.dart';
import 'package:cood/features/categories/domain/use_case/categories_use_case.dart';
import 'package:cood/features/categories/domain/use_case/additional_use_case.dart';
import 'package:cood/features/categories/domain/use_case/check_reserve_status_usecase.dart';
import 'package:cood/features/categories/domain/use_case/complete_applepay_usecase.dart';
import 'package:cood/features/categories/domain/use_case/get_apple_config_usecase.dart';
import 'package:cood/features/categories/domain/use_case/get_plans_usecase.dart';
import 'package:cood/features/categories/domain/use_case/get_price_status_usecase.dart';
import 'package:cood/features/categories/domain/use_case/make_reserve_usecase.dart';
import 'package:cood/features/categories/presentation/cubit/apple_pay_config_cubit/apple_pay_config_cubit.dart';
import 'package:cood/features/categories/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:cood/features/categories/presentation/cubit/categories_cubit/categories_data_cubit.dart';
import 'package:cood/features/categories/presentation/cubit/check_reserve_status/check_reserve_status_cubit.dart';
import 'package:cood/features/categories/presentation/cubit/complete_applepay_cubit/complete_applepay_cubit.dart';
import 'package:cood/features/categories/presentation/cubit/coupon_validation/coupon_validation_cubit.dart';
import 'package:cood/features/categories/presentation/cubit/price_status_cubit/price_status_cubit.dart';
import 'package:cood/features/categories/presentation/cubit/reserve_cubit/reserve_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '/injection_container.dart';

final _sl = ServiceLocator.instance;
Future<void> initCategoriesInjection() async {
  _sl.registerFactory<CategoriesCubit>(
      () => CategoriesCubit(_sl(), _sl(), _sl()));
  _sl.registerFactory<CategoriesDataCubit>(() => CategoriesDataCubit());
  _sl.registerFactory<CheckReserveStatusCubit>(
      () => CheckReserveStatusCubit(checkReserveUseCase: _sl()));
  _sl.registerFactory<ReserveCubit>(
      () => ReserveCubit(makeReserveUseCase: _sl()));
  _sl.registerFactory<APayConfigCubit>(
      () => APayConfigCubit(getAppleConfigUseCase: _sl()));
  _sl.registerFactory<PriceStatusCubit>(
      () => PriceStatusCubit(getPriceStatusUseCase: _sl()));
  _sl.registerFactory<CompleteApplePayCubit>(
      () => CompleteApplePayCubit(completeAPayUseCase: _sl()));
  _sl.registerFactory<CouponValidationCubit>(
      () => CouponValidationCubit(checkReserveUseCase: _sl()));

  /// UseCases
  _sl.registerLazySingleton<CategoriesUseCase>(
      () => CategoriesUseCase(categoriesRepository: _sl()));
  _sl.registerLazySingleton<CheckReserveUseCase>(
      () => CheckReserveUseCase(categoriesRepositry: _sl()));
  _sl.registerLazySingleton<MakeReserveUseCase>(
      () => MakeReserveUseCase(categoriesRepositry: _sl()));
  _sl.registerLazySingleton<GetAppleConfigUseCase>(
      () => GetAppleConfigUseCase(categoriesRepositry: _sl()));
  _sl.registerLazySingleton<GetPriceStatusUseCase>(
      () => GetPriceStatusUseCase(categoriesRepository: _sl()));
  _sl.registerLazySingleton<CompleteAPayUseCase>(
      () => CompleteAPayUseCase(categoriesRepository: _sl()));

  _sl.registerLazySingleton<GetPlansUseCase>(
      () => GetPlansUseCase(categoriesRepository: _sl()));

  _sl.registerLazySingleton<GetAdditionalUseCase>(
      () => GetAdditionalUseCase(categoriesRepository: _sl()));

  /// Repository
  _sl.registerLazySingleton<CategoriesRepositry>(
      () => CategoriesRepositryImpl(
            remoteDataSource: _sl(),
          ));

  /// DataSource
  _sl.registerLazySingleton<CategoriesRemoteDatesource>(
      () => ReservationRemoteDataSourceImpl());
}

/// BlocProviders
List<BlocProvider> get categoriesBlocs => <BlocProvider>[
      BlocProvider<CategoriesCubit>(
        create: (BuildContext context) => _sl<CategoriesCubit>(),
      ),
      BlocProvider<CategoriesDataCubit>(
        create: (BuildContext context) => _sl<CategoriesDataCubit>(),
      ),
      BlocProvider<CheckReserveStatusCubit>(
        create: (BuildContext context) => _sl<CheckReserveStatusCubit>(),
      ),
      BlocProvider<ReserveCubit>(
        create: (BuildContext context) => _sl<ReserveCubit>(),
      ),
      BlocProvider<APayConfigCubit>(
        create: (BuildContext context) => _sl<APayConfigCubit>(),
      ),
      BlocProvider<PriceStatusCubit>(
        create: (BuildContext context) => _sl<PriceStatusCubit>(),
      ),
      BlocProvider<CompleteApplePayCubit>(
        create: (BuildContext context) => _sl<CompleteApplePayCubit>(),
      ),
      BlocProvider<CouponValidationCubit>(
        create: (BuildContext context) => _sl<CouponValidationCubit>(),
      ),
    ];
