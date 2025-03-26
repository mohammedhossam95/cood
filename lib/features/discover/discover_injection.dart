import 'package:cood/features/discover/data/datasources/discover_remote_data_source.dart';
import 'package:cood/features/discover/data/repositories/discover_repo_impl.dart';
import 'package:cood/features/discover/domain/repositories/discover_repo.dart';

import '/features/profile/domain/usecases/get_user_usecase.dart';
import '/features/profile/presentation/cubit/get_user_cubit/get_user_cubit.dart';
import '/injection_container.dart';

final _sl = ServiceLocator.instance;

Future<void> initDiscoverFeatureInjection() async {
  ///-> Cubits
  _sl.registerFactory<GetUserCubit>(() => GetUserCubit(getUserUsecase: _sl()));

  ///-> UseCases
  _sl.registerFactory<GetUserUsecase>(() => GetUserUsecase(repository: _sl()));

// Repository
  _sl.registerFactory<DiscoverRepo>(() => DiscoverRepoImpl(remote: _sl()));

  ///-> DataSource
  _sl.registerLazySingleton<DiscoverRemoteDataSource>(
      () => DiscoverRemoteDataSourceImpl());
}
