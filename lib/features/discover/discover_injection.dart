import 'package:cood/features/discover/data/datasources/discover_remote_data_source.dart';
import 'package:cood/features/discover/data/repositories/discover_repo_impl.dart';
import 'package:cood/features/discover/domain/repositories/discover_repo.dart';
import 'package:cood/features/discover/domain/usecases/add_story_use_case.dart';
import 'package:cood/features/discover/domain/usecases/get_stories_use_case.dart';
import 'package:cood/features/discover/presentation/cubit/add_story_cubit/add_story_cubit.dart';
import 'package:cood/features/discover/presentation/cubit/stories_cubit/stories_cubit.dart';

import '/injection_container.dart';

final _sl = ServiceLocator.instance;

Future<void> initDiscoverFeatureInjection() async {
  ///-> Cubits
  _sl.registerFactory<StoriesCubit>(() => StoriesCubit(_sl()));
  _sl.registerFactory<AddStoryCubit>(() => AddStoryCubit(_sl()));

  ///-> UseCases
  _sl.registerLazySingleton<GetStoriesUseCase>(
      () => GetStoriesUseCase(discoverRepo: _sl()));
  _sl.registerLazySingleton<AddStoryUseCase>(
      () => AddStoryUseCase(discoverRepo: _sl()));

// Repository
  _sl.registerLazySingleton<DiscoverRepo>(
      () => DiscoverRepoImpl(remote: _sl()));

  ///-> DataSource
  _sl.registerLazySingleton<DiscoverRemoteDataSource>(
      () => DiscoverRemoteDataSourceImpl());
}
