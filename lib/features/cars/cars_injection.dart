import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/cars/data/datasources/cars_remote_data_source.dart';
import '/features/cars/data/repositories/cars_repo_impl.dart';
import '/features/cars/domain/repositories/cars_repo.dart';
import '/features/cars/domain/usecases/get_additional_usecase.dart';
import '/features/cars/domain/usecases/get_agents_usecase.dart';
import '/features/cars/domain/usecases/get_branches_usecase.dart';
import '/features/cars/domain/usecases/get_brands_usecase.dart';
import '/features/cars/domain/usecases/get_cars_usecase.dart';
import '/features/cars/domain/usecases/get_categories_usecase.dart';
import '/features/cars/domain/usecases/get_free_additional_usecase.dart';
import '/features/cars/presentation/bloc/branches_bloc.dart';
import '/features/cars/presentation/cubit/get_additional_cubit/get_additional_cubit.dart';
import '/features/cars/presentation/cubit/get_agents_cubit/get_agents_cubit.dart';
import '/features/cars/presentation/cubit/get_brands_cubit/get_brands_cubit.dart';
import '/features/cars/presentation/cubit/get_cars_cubit/get_cars_cubit.dart';
import '/features/cars/presentation/cubit/get_categories_cubit/get_categories_cubit.dart';
import '/features/cars/presentation/cubit/get_free_additional_cubit/get_free_additional_cubit.dart';
import '/injection_container.dart';

final _sl = ServiceLocator.instance;

Future<void> initCarsFeatureInjection() async {
  ///-> Cubits
  // Blocs
  _sl.registerFactory<GetCarsCubit>(() => GetCarsCubit(getCarsUsecase: _sl()));
  _sl.registerFactory<GetAdditionalCubit>(
      () => GetAdditionalCubit(getAdditionalUsecase: _sl()));
  _sl.registerFactory<GetFreeAdditionalCubit>(
      () => GetFreeAdditionalCubit(getFreeAdditionalUsecase: _sl()));
  _sl.registerFactory<GetBrandsCubit>(
      () => GetBrandsCubit(getBrandsUsecase: _sl()));
  _sl.registerFactory<GetCategoriesCubit>(
      () => GetCategoriesCubit(getCategoriesUsecase: _sl()));

  _sl.registerFactory<BranchesBloc>(
      () => BranchesBloc(getBranchesUseCase: _sl()));

  _sl.registerFactory<GetAgentsCubit>(
      () => GetAgentsCubit(getAgentsUseCase: _sl()));

// Repository
  _sl.registerFactory<CarsRepo>(() => CarsRepoImpl(remote: _sl()));

  ///-> UseCases
  _sl.registerFactory<GetCarsUsecase>(() => GetCarsUsecase(repository: _sl()));
  _sl.registerFactory<GetAdditionalUsecase>(
      () => GetAdditionalUsecase(repository: _sl()));
  _sl.registerFactory<GetFreeAdditionalUsecase>(
      () => GetFreeAdditionalUsecase(repository: _sl()));
  _sl.registerFactory<GetBrandsUsecase>(
      () => GetBrandsUsecase(repository: _sl()));
  _sl.registerFactory<GetCategoriesUsecase>(
      () => GetCategoriesUsecase(repository: _sl()));

  _sl.registerFactory<GetAgentsUseCase>(
      () => GetAgentsUseCase(repository: _sl()));

  _sl.registerFactory<GetBranchesUsecase>(
      () => GetBranchesUsecase(repository: _sl()));

  ///-> DataSource
  _sl.registerLazySingleton<CarsRemoteDataSource>(
      () => CarsRemoteDataSourceImpl());
}

///-> BlocProvider
List<BlocProvider> get carsBlocs => <BlocProvider>[
      BlocProvider<GetCarsCubit>(
        create: (BuildContext context) => _sl<GetCarsCubit>(),
      ),
      BlocProvider<GetBrandsCubit>(
        create: (BuildContext context) => _sl<GetBrandsCubit>(),
      ),
      BlocProvider<GetCategoriesCubit>(
        create: (BuildContext context) => _sl<GetCategoriesCubit>(),
      ),
      BlocProvider<GetAdditionalCubit>(
        create: (BuildContext context) => _sl<GetAdditionalCubit>(),
      ),
      BlocProvider<GetFreeAdditionalCubit>(
        create: (BuildContext context) => _sl<GetFreeAdditionalCubit>(),
      ),
      BlocProvider<BranchesBloc>(
        create: (BuildContext context) => _sl<BranchesBloc>(),
      ),
      BlocProvider<GetAgentsCubit>(
        create: (BuildContext context) => _sl<GetAgentsCubit>(),
      ),
    ];
