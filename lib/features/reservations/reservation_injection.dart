import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/reservations/data/datasource/reservation_remote_datesource.dart';
import '/features/reservations/data/repositry_imple/reservation_repositry_impl.dart';
import '/features/reservations/domain/repository/reservation_repository.dart';
import '/features/reservations/domain/use_case/additional_use_case.dart';
import '/features/reservations/domain/use_case/check_reserve_status_usecase.dart';
import '/features/reservations/domain/use_case/complete_applepay_usecase.dart';
import '/features/reservations/domain/use_case/get_apple_config_usecase.dart';
import '/features/reservations/domain/use_case/get_plans_usecase.dart';
import '/features/reservations/domain/use_case/get_price_status_usecase.dart';
import '/features/reservations/domain/use_case/make_reserve_usecase.dart';
import '/features/reservations/domain/use_case/reservation_use_case.dart';
import '/features/reservations/presentation/cubit/apple_pay_config_cubit/apple_pay_config_cubit.dart';
import '/features/reservations/presentation/cubit/check_reserve_status/check_reserve_status_cubit.dart';
import '/features/reservations/presentation/cubit/complete_applepay_cubit/complete_applepay_cubit.dart';
import '/features/reservations/presentation/cubit/coupon_validation/coupon_validation_cubit.dart';
import '/features/reservations/presentation/cubit/price_status_cubit/price_status_cubit.dart';
import '/features/reservations/presentation/cubit/reservation_cubit/reservation_cubit.dart';
import '/features/reservations/presentation/cubit/reservation_cubit/reservation_data_cubit.dart';
import '/features/reservations/presentation/cubit/reserve_cubit/reserve_cubit.dart';
import '/injection_container.dart';

final _sl = ServiceLocator.instance;
Future<void> initReservationInjection() async {
  _sl.registerFactory<ReservationCubit>(
      () => ReservationCubit(_sl(), _sl(), _sl()));
  _sl.registerFactory<ReservationDataCubit>(() => ReservationDataCubit());
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
  _sl.registerLazySingleton<ReservationUseCase>(
      () => ReservationUseCase(reservationRepositry: _sl()));
  _sl.registerLazySingleton<CheckReserveUseCase>(
      () => CheckReserveUseCase(reservationRepositry: _sl()));
  _sl.registerLazySingleton<MakeReserveUseCase>(
      () => MakeReserveUseCase(reservationRepositry: _sl()));
  _sl.registerLazySingleton<GetAppleConfigUseCase>(
      () => GetAppleConfigUseCase(reservationRepositry: _sl()));
  _sl.registerLazySingleton<GetPriceStatusUseCase>(
      () => GetPriceStatusUseCase(reservationRepositry: _sl()));
  _sl.registerLazySingleton<CompleteAPayUseCase>(
      () => CompleteAPayUseCase(reservationRepositry: _sl()));

  _sl.registerLazySingleton<GetPlansUseCase>(
      () => GetPlansUseCase(reservationRepositry: _sl()));

  _sl.registerLazySingleton<GetAdditionalUseCase>(
      () => GetAdditionalUseCase(reservationRepositry: _sl()));

  /// Repository
  _sl.registerLazySingleton<ReservationRepositry>(
      () => ReservationRepositryImpl(
            remoteDataSource: _sl(),
          ));

  /// DataSource
  _sl.registerLazySingleton<ReservationRemoteDataSource>(
      () => ReservationRemoteDataSourceImpl());
}

/// BlocProviders
List<BlocProvider> get reservationBlocs => <BlocProvider>[
      BlocProvider<ReservationCubit>(
        create: (BuildContext context) => _sl<ReservationCubit>(),
      ),
      BlocProvider<ReservationDataCubit>(
        create: (BuildContext context) => _sl<ReservationDataCubit>(),
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
