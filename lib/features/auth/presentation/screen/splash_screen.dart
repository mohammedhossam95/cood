import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/values/assets.dart';
import '../../../../injection_container.dart';
import '../cubit/auto_login/auto_login_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkNotificationPermission();
    super.initState();
  }

  checkNotificationPermission() async {
    context.read<AutoLoginCubit>().getUserCycle();
  }

  void injectLocalizationAndColors() {
    // inject for once time
    try {
      // appLocalizations;
      colors;
    } catch (e) {
      // ServiceLocator.injectAppLocalizations(context: context);
      ServiceLocator.injectAppColors(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    injectLocalizationAndColors();
    log('Localizations: ${appLocalizations.locale?.languageCode}');
    return BlocListener<AutoLoginCubit, AutoLoginState>(
      listener: (context, state) {
        // log('UserType: ${state.userCycle}');
        state is AutoLoginUserCycleState ? _goNext(state.userCycle) : () {};
      },
      child: Scaffold(
        backgroundColor: colors.backGround,
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                        width: 184.w, height: 133.h, ImgAssets.jzlLogo),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _goNext(UserCycle userCycle) {
    // if (userCycle == UserCycle.firstOpen) {
    //   Navigator.pushNamedAndRemoveUntil(
    //     context,
    //     Routes.onBoardingRoute,
    //     (route) => false,
    //   );
    // } else
    if (userCycle == UserCycle.login) {
      Navigator.pushReplacementNamed(context, Routes.loginScreenRoute);
    } else if (userCycle == UserCycle.auth) {
      Navigator.pushReplacementNamed(context, Routes.mainPageRoute);
    } else if (userCycle == UserCycle.guest) {
      Navigator.pushReplacementNamed(context, Routes.mainPageRoute);
    }
  }
}
