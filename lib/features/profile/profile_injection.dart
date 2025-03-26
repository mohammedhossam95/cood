import 'package:cood/features/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:cood/features/profile/presentation/cubit/edit_profile_cubit/edit_profile_cubit.dart';

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
  _sl.registerFactory<EditProfileCubit>(
      () => EditProfileCubit(editProfileUseCase: _sl()));

  ///-> UseCases
  _sl.registerFactory<GetUserUsecase>(() => GetUserUsecase(repository: _sl()));
  _sl.registerFactory<EditProfileUseCase>(
      () => EditProfileUseCase(profileRepo: _sl()));

// Repository
  _sl.registerFactory<ProfileRepo>(() => ProfileRepoImpl(remote: _sl()));

  ///-> DataSource
  _sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl());
}
