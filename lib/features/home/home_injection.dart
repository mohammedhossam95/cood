import 'package:cood/features/home/domain/usecases/get_all_user_gallary_use_case.dart';
import 'package:cood/features/home/presentation/cubit/get_all_user_gallary/get_user_gallary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/home/data/datasources/home_remote_data_source.dart';
import '/features/home/data/repositories/home_repo_impl.dart';
import '/features/home/domain/repositories/home_repo.dart';
import '/features/home/domain/usecases/get_cities_use_case.dart';
import '/features/home/presentation/bloc/cities_bloc/cities_bloc.dart';
import '/features/home/presentation/cubit/get_cities_cubit/get_cities_cubit.dart';
import '/injection_container.dart';

final _sl = ServiceLocator.instance;

Future<void> initHomeFeatureInjection() async {
  ///-> Cubits
  // Blocs
  //-----------------------this is new-------------------
  _sl.registerFactory<GetUserGallaryCubit>(
      () => GetUserGallaryCubit( _sl()));
  _sl.registerFactory<GetAllUserGallaryUseCase>(
      () => GetAllUserGallaryUseCase(repository: _sl())); 
  _sl.registerFactory<HomeRepo>(() => HomeRepoImpl(remote: _sl()));
  _sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl());       
//-----------------------------------------------
  _sl.registerFactory<GetCitiesCubit>(
      () => GetCitiesCubit(getCitiesUsecase: _sl()));
  _sl.registerFactory<CitiesBloc>(() => CitiesBloc(getCitiesUseCase: _sl()));

  ///-> UseCases

  _sl.registerFactory<GetCitiesUseCase>(
      () => GetCitiesUseCase(repository: _sl()));

// Repository
  _sl.registerFactory<HomeRepo>(() => HomeRepoImpl(remote: _sl()));

  ///-> DataSource
  _sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl());
}

///-> BlocProvider
List<BlocProvider> get homeBlocs => <BlocProvider>[
     //----------------new----------
     BlocProvider<GetUserGallaryCubit>(
        create: (BuildContext context) => _sl<GetUserGallaryCubit>(),
      ),
     //----------------------------
      BlocProvider<GetCitiesCubit>(
        create: (BuildContext context) => _sl<GetCitiesCubit>(),
      ),
      BlocProvider<CitiesBloc>(
        create: (BuildContext context) => _sl<CitiesBloc>(),
      ),
    ];
