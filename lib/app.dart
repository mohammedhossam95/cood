import 'dart:developer';

import 'package:cood/features/categories/categories_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/features/cars/cars_injection.dart';
import '/features/home/home_injection.dart';
import '/features/tabbar/tabbar_injection.dart';
import 'config/locale/app_localizations_setup.dart';
import 'config/routes/app_routes.dart';
import 'config/routes/navigator_observer.dart';
import 'config/themes/app_theme.dart';
import 'core/utils/app_strings.dart';
import 'features/language/language_injection.dart';
import 'features/language/presentation/cubit/locale_cubit/locale_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...languageBlocs,
        ...bottomNavBlocs,
        ...carsBlocs,
        ...homeBlocs,
        // Define reservationBlocs or remove this line if not needed
        ...categoriesBlocs,
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        buildWhen: (previous, current) {
          return previous.locale.languageCode != current.locale.languageCode;
        },
        builder: (context, state) {
          log('LocaleCubit state: ${state.locale.languageCode}');
          return LayoutBuilder(builder: (context, constrants) {
            return ScreenUtilInit(
              designSize: Size(
                constrants.maxWidth,
                constrants.maxHeight,
                // AppStrings.screenWidth,
                // AppStrings.screenHeight,
              ),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp(
                  title: AppStrings.appName,
                  locale: state.locale,
                  debugShowCheckedModeBanner: false,
                  theme: getAppTheme(context, true),
                  onGenerateRoute: AppRoutes.onGenerateRoute,
                  supportedLocales: AppLocalizationsSetup.supportedLocales,
                  localeResolutionCallback:
                      AppLocalizationsSetup.localeResolutionCallback,
                  localizationsDelegates:
                      AppLocalizationsSetup.localizationsDelegates,
                  navigatorObservers: <NavigatorObserver>[
                    AppNavigatorObserver()
                  ],
                );
              },
            );
          });
        },
      ),
    );
  }
}
