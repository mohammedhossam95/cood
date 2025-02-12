import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/features/cars/cars_injection.dart';
import '/features/home/home_injection.dart';
import '/features/profile/profile_injection.dart';
import '/features/reservations/reservation_injection.dart';
import '/features/tabbar/tabbar_injection.dart';
import 'config/locale/app_localizations_setup.dart';
import 'config/routes/app_routes.dart';
import 'config/routes/navigator_observer.dart';
import 'config/themes/app_theme.dart';
import 'config/themes/provider/app_theme_provider.dart';
import 'core/utils/app_strings.dart';
import 'features/auth/auth_injection.dart';
import 'features/language/language_injection.dart';
import 'features/language/presentation/cubit/locale_cubit/locale_cubit.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MultiBlocProvider(
      providers: [
        ...languageBlocs,
        ...authBlocs,
        ...bottomNavBlocs,
        ...carsBlocs,
        ...homeBlocs,
        ...reservationBlocs,
        ...profileBlocs,
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
                  theme: getAppTheme(context, ref.watch(appThemeProvider)),
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
