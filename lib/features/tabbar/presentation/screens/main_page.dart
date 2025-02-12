// ignore_for_file: deprecated_member_use

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/enums.dart';
import '/core/widgets/exit_app_dialog.dart';
import '/core/widgets/show_dialog.dart';
import '/features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '../../../../core/utils/values/strings.dart';
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
    AppLocalizations locale = AppLocalizations.of(context)!;
    bool isRtl = locale.isArLocale;
    return BlocConsumer<BottomNavBarCubit, BottomNavBarState>(
      listenWhen: (pre, current) => pre.index != current.index,
      listener: (context, state) {},
      builder: (context, state) {
        return PopScope(
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
            appBar: state.index != 0
                ? AppBar(
                    leading: BackButton(
                      color: colors.main,
                    ),
                    backgroundColor: colors.upBackGround,
                    elevation: 4,
                    title: Container(
                      width: ScreenUtil().screenWidth,
                      alignment:
                          isRtl ? Alignment.centerLeft : Alignment.centerRight,
                      child: Text(
                        state.index == 3
                            ? "more".tr
                            : state.index == 1
                                ? "reservations".tr
                                : "offers".tr,
                        style: TextStyles.semiBold16(color: colors.main),
                      ),
                    ),
                  )
                : null,
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  color: colors.main,
                  border: Border.all(width: 1, color: Colors.grey[200]!)),
              child: GNav(
                selectedIndex: state.index,
                onTabChange: (index) => context
                    .read<BottomNavBarCubit>()
                    .changeCurrentScreen(index: index),
                textSize: 20.sp,
                color: Colors.white,

                gap: 2.r,
                activeColor: Colors.white,
                // tabBackgroundColor: colors.main,
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                style: GnavStyle.oldSchool,
                // navigation bar padding
                tabs: [
                  GButton(
                    icon: Icons.home_outlined,
                    text: Strings.home,
                    iconSize: 30.r,
                  ),
                  GButton(
                    icon: FontAwesomeIcons.bookOpen,
                    text: 'tapBarItemCommunicationGuide'.tr,
                    iconSize: 30.r,
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'tapBarItemMyAccount'.tr,
                    iconSize: 30.r,
                  ),
                ],
              ),
            ),
            body: context.read<BottomNavBarCubit>().screens[state.index],
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
