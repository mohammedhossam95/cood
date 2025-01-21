import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/profile/data/datasources/profile_remote_data_source.dart';
import '/features/profile/data/repositories/profile_repo_impl.dart';
import '/features/profile/domain/repositories/profile_repo.dart';
import '/features/profile/domain/usecases/get_user_usecase.dart';
import '/features/profile/presentation/cubit/get_user_cubit/get_user_cubit.dart';
import '/injection_container.dart';

final _sl = ServiceLocator.instance;

Future<void> initProfileFeatureInjection() async {
  ///-> Cubits
  _sl.registerFactory<GetUserCubit>(() => GetUserCubit(getUserUsecase: _sl()));

  ///-> UseCases
  _sl.registerFactory<GetUserUsecase>(() => GetUserUsecase(repository: _sl()));

// Repository
  _sl.registerFactory<ProfileRepo>(() => ProfileRepoImpl(remote: _sl()));

  ///-> DataSource
  _sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl());
}

///-> BlocProvider
List<BlocProvider> get profileBlocs => <BlocProvider>[
      BlocProvider<GetUserCubit>(
        create: (BuildContext context) => _sl<GetUserCubit>(),
      ),
    ];
