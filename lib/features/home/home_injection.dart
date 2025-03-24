import 'package:cood/features/home/domain/usecases/add_user_account_use_case.dart';
import 'package:cood/features/home/domain/usecases/get_all_social_media_use_case.dart';
import 'package:cood/features/home/domain/usecases/get_all_user_gallary_use_case.dart';
import 'package:cood/features/home/domain/usecases/get_friends_list_use_case.dart';
import 'package:cood/features/home/domain/usecases/get_user_social_media_use_case.dart';
import 'package:cood/features/home/domain/usecases/search_user_by_code_use_case.dart';
import 'package:cood/features/home/presentation/cubit/add_user_social_account/add_user_social_account_cubit.dart';
import 'package:cood/features/home/presentation/cubit/get_all_social_media/get_all_social_media_cubit.dart';
import 'package:cood/features/home/presentation/cubit/get_all_user_gallary/get_user_gallary_cubit.dart';
import 'package:cood/features/home/presentation/cubit/get_friends_list/friends_list_cubit.dart';
import 'package:cood/features/home/presentation/cubit/get_search_user_by_code/get_search_user_by_code_cubit.dart';
import 'package:cood/features/home/presentation/cubit/get_user_social_media/get_user_social_media_cubit.dart';
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
  //----------------new GetSearchUserByCodeCubit----------------
  _sl.registerFactory<GetSearchUserByCodeCubit>(
      () => GetSearchUserByCodeCubit( _sl()));
  _sl.registerFactory<GetSearchUserByCodeUseCase>(
      () => GetSearchUserByCodeUseCase( repository: _sl())); 
  //----------------new friendList----------------
    _sl.registerFactory<FriendsListCubit>(
      () => FriendsListCubit( getFriendsListUseCase: _sl()));
  _sl.registerFactory<GetFriendsListUseCase>(
      () => GetFriendsListUseCase( _sl())); 
  _sl.registerFactory<HomeRepo>(() => HomeRepoImpl(remote: _sl()));
  _sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl());  
  //-----------------------this is new gallary-------------------
  _sl.registerFactory<GetUserGallaryCubit>(
      () => GetUserGallaryCubit( _sl()));
  _sl.registerFactory<GetAllUserGallaryUseCase>(
      () => GetAllUserGallaryUseCase(repository: _sl())); 
      
//-----------------------this is new user social media-------------------
  _sl.registerFactory<GetUserSocialMediaCubit>(
      () => GetUserSocialMediaCubit( _sl()));
  _sl.registerFactory<GetUserSocialMediaUseCase>(
      () => GetUserSocialMediaUseCase( _sl())); 
       
//-----------------------this is new user social media-------------------
  _sl.registerFactory<GetAllSocialMediaCubit>(
      () => GetAllSocialMediaCubit( _sl()));
  _sl.registerFactory<GetAllSocialMediaUseCase>(
      () => GetAllSocialMediaUseCase( _sl())); 
  
//-----------------------this is new Add user social media account-------------------
  _sl.registerFactory<AddUserSocialAccountCubit>(
      () => AddUserSocialAccountCubit( _sl()));
  _sl.registerFactory<AddUserSocialAccountUseCase>(
      () => AddUserSocialAccountUseCase( _sl())); 
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
      BlocProvider<GetSearchUserByCodeCubit>(
        create: (BuildContext context) => _sl<GetSearchUserByCodeCubit>(),
      ),
     BlocProvider<AddUserSocialAccountCubit>(
        create: (BuildContext context) => _sl<AddUserSocialAccountCubit>(),
      ),
     BlocProvider<GetAllSocialMediaCubit>(
        create: (BuildContext context) => _sl<GetAllSocialMediaCubit>(),
      ),
     BlocProvider<GetUserSocialMediaCubit>(
        create: (BuildContext context) => _sl<GetUserSocialMediaCubit>(),
      ),
     BlocProvider<GetUserGallaryCubit>(
        create: (BuildContext context) => _sl<GetUserGallaryCubit>(),
      ),
      BlocProvider<FriendsListCubit>(
        create: (BuildContext context) => _sl<FriendsListCubit>(),
      ),
     //----------------------------
      BlocProvider<GetCitiesCubit>(
        create: (BuildContext context) => _sl<GetCitiesCubit>(),
      ),
      BlocProvider<CitiesBloc>(
        create: (BuildContext context) => _sl<CitiesBloc>(),
      ),
    ];
