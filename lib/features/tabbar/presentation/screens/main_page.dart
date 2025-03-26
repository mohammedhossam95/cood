// ignore_for_file: deprecated_member_use

import 'package:badges/badges.dart' as badges;
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/utils/values/svg_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/enums.dart';
import '/core/widgets/exit_app_dialog.dart';
import '/core/widgets/show_dialog.dart';
import '/features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../injection_container.dart';
import '../cubit/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageStorageBucket bucket = PageStorageBucket();
  UserType? userType;
  @override
  void initState() {
    getUser();
    super.initState();
  }

  _onWillPop(didPop) async {
    if (!didPop) {
      var state = BlocProvider.of<BottomNavBarCubit>(context).state;
      if (state.index != 0) {
        context.read<BottomNavBarCubit>().changeCurrentScreen(index: 0);
      } else {
        await showAppDialog(
          context: context,
          child: const ExitAppDialog(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavBarCubit, BottomNavBarState>(
      listenWhen: (pre, current) => pre.index != current.index,
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          color: colors.main,
          child: SafeArea(
            child: PopScope(
              canPop: false,
              // onPopInvoked: (value) async {
              //   await showAppDialog(
              //         context: context,
              //         child: const ExitAppDialog(),
              //       ) ??
              //       false;
              // },
              onPopInvoked: _onWillPop,
              child: Scaffold(
                backgroundColor: MyColors.backGround,
                // appBar: state.index != 0
                //     ? AppBar(
                //         leading: BackButton(
                //           color: colors.main,
                //         ),
                //         backgroundColor: MyColors.backGround,
                //         elevation: 0,
                //         title: Container(
                //           width: ScreenUtil().screenWidth,
                //           alignment:
                //               isRtl ? Alignment.centerLeft : Alignment.centerRight,
                //           child: Text(
                //             state.index == 2
                //                 ? "more".tr
                //                 : state.index == 1
                //                     ? "reservations".tr
                //                     : "offers".tr,
                //             style: TextStyles.bold32(color: colors.main),
                //           ),
                //         ),
                //       )
                //     : null,
                bottomNavigationBar: Container(
                  height: 80.r,
                  decoration: BoxDecoration(
                    color: colors.main,
                  ),
                  child: BottomAppBar(
                    padding: EdgeInsets.zero,
                    child: BottomNavigationBar(
                      currentIndex: state.index,
                      backgroundColor: colors.main,
                      selectedItemColor: colors.upBackGround,
                      unselectedItemColor: colors.upBackGround,
                      selectedIconTheme: const IconThemeData(
                        color: Colors.white,
                      ),
                      selectedLabelStyle:
                          TextStyles.bold14(color: colors.upBackGround),
                      unselectedLabelStyle:
                          TextStyles.bold14(color: colors.upBackGround),
                      // elevation: 0.0,
                      iconSize: 24.r,
                      onTap: (index) => context
                          .read<BottomNavBarCubit>()
                          .changeCurrentScreen(index: index),
                      items: [
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            SvgAssets.homeTab,
                            width: 24.w,
                            height: 24.h,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          label: "home".tr,
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            SvgAssets.discoverTab,
                            width: 24.w,
                            height: 24.h,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          label: "discover".tr,
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            SvgAssets.bookmarkTab,
                            width: 24.w,
                            height: 24.h,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          label: 'tapBarItemCommunicationGuide'.tr,
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            SvgAssets.userTab,
                            width: 24.w,
                            height: 24.h,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          label: 'tapBarItemMyAccount'.tr,
                        ),
                      ],
                    ),
                  ),

                  /*
                  GNav(
                    selectedIndex: state.index,
                    onTabChange: (index) => context
                        .read<BottomNavBarCubit>()
                        .changeCurrentScreen(index: index),
                    textSize: 16.sp,
                    color: Colors.white,
                    gap: 2.r,
                    activeColor: Colors.white,
                    // tabBackgroundColor: colors.main,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    style: GnavStyle.oldSchool,
                    // navigation bar padding
                    tabs: [
                      GButton(
                        icon: Icons.home_outlined,
                        text: Strings.home,
                        iconSize: 20.r,
                      ),
                      GButton(
                        icon: FontAwesomeIcons.bookOpen,
                        text: 'tapBarItemCommunicationGuide'.tr,
                        iconSize: 20.r,
                      ),
                      GButton(
                        icon: Icons.person,
                        text: 'tapBarItemMyAccount'.tr,
                        iconSize: 20.r,
                      ),
                    ],
                  ),
                */
                ),
                body: context.read<BottomNavBarCubit>().screens[state.index],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget notificationBadge({
    required String iconSvg,
    required int unreadCounter,
  }) {
    return badges.Badge(
      position: badges.BadgePosition.topStart(top: -6, start: -4),
      showBadge: true,
      ignorePointer: false,
      badgeContent: Text(
        unreadCounter > 99 ? '99+' : unreadCounter.toString(),
        style: TextStyles.medium10(color: colors.upBackGround),
      ),
      badgeAnimation: const badges.BadgeAnimation.rotation(
        animationDuration: Duration(seconds: 1),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
        colorChangeAnimationCurve: Curves.easeInCubic,
      ),
      badgeStyle: badges.BadgeStyle(
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        shape: badges.BadgeShape.circle,
        badgeColor: colors.errorColor,
      ),
      child: SvgPicture.asset(iconSvg),
    );
  }

  getUser() async {
    userType = await BlocProvider.of<AutoLoginCubit>(context).getUserType();
    setState(() {});
  }
}
