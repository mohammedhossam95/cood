import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '/config/routes/app_routes.dart';
import '/core/utils/enums.dart';
import '/core/utils/values/assets.dart';
import '/features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '/features/auth/presentation/widgets/page_widget.dart';
import '/injection_container.dart';
import '../../data/models/welcome_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentIndex = 0;
  final _controller = PageController();
  final _pageIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    context.read<AutoLoginCubit>().saveUserCycle(type: UserCycle.login);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.upBackGround,
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: appLocalizations.isEnLocale
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              // child: Image.asset(Assets.onBoardingOneBackGroundImage),
              child: Container(
                height: ScreenUtil().screenHeight,
                width: 30.w,
                color: colors.main,
              ),
            ),

            PageView(
              controller: _controller,
              onPageChanged: (val) {
                _pageIndexNotifier.value = val;

                setState(() {
                  _currentIndex = val;
                });
              },
              children: pages
                  .map(
                    (page) => MyPageView(
                      page: page,
                      index: _currentIndex,
                      updateIndex: (val) {
                        if (_currentIndex < 2) {
                          _currentIndex++;

                          _controller.animateToPage(
                            _currentIndex,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.pushNamed(context, Routes.loginScreenRoute);
                        }
                      },
                    ),
                  )
                  .toList(),
            ),
            Positioned(
              left: appLocalizations.isEnLocale ? null : 0,
              right: appLocalizations.isEnLocale ? 0 : null,
              top: ScreenUtil().screenHeight * .5,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    appLocalizations.isEnLocale
                        ? 'assets/images/Ellipse_3_en.png'
                        : 'assets/images/Ellipse_3.png',
                    fit: BoxFit.scaleDown,
                  ),
                  Positioned(
                    bottom: 0,
                    top: 0,
                    right: 25,
                    left: 25,
                    child: InkWell(
                      onTap: () {
                        if (_currentIndex < 2) {
                          _currentIndex++;

                          _controller.animateToPage(
                            _currentIndex,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.pushNamed(context, Routes.loginScreenRoute);
                        }
                      },
                      child: IgnorePointer(
                        child: Container(
                          width: 60.w,
                          height: 60.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.w),
                              ),
                              color: colors.main,
                              elevation: 10,
                              child: SvgPicture.asset(
                                appLocalizations.isEnLocale
                                    ? ImgAssets.imagesLogoAr
                                    : ImgAssets.imagesLogoAr,
                                fit: BoxFit.scaleDown,
                                width: 50.w,
                                height: 50.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Positioned(
            //   bottom: ScreenUtil.defaultSize.height * .425,
            //   // right: 10.w,
            //   left: 10.w,
            //   child: FloatingActionButton(
            //     backgroundColor: Colors.transparent,
            //     elevation: 0,
            //     shape: const CircleBorder(),
            //     onPressed: () {
            //       if (_currentIndex < 2) {
            //         _currentIndex++;

            //         _controller.animateToPage(
            //           _currentIndex,
            //           duration: const Duration(milliseconds: 100),
            //           curve: Curves.easeInOut,
            //         );
            //       } else {
            //         Navigator.pushNamed(context, Routes.kindUserRoute);
            //       }
            //     },
            //     child: SvgPicture.asset(
            //       Assets.onBoardingButtonSvg,
            //       width: 60.w,
            //       height: 60.h,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // _submit() async {
  //   AppSharedPreferences.saveCheckFirst(false);
  //   Navigator.pushNamed(context, Routes.loginScreenRoute);
  // }
}
