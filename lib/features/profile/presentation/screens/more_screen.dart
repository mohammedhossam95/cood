// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/constants.dart';
import 'package:cood/core/utils/enums.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/diff_img.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/features/auth/domain/entities/login_response.dart';
import 'package:cood/features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import 'package:cood/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '/config/routes/app_routes.dart';
import '/core/widgets/gaps.dart';
import '../../../../core/utils/values/assets.dart';
import '../widgets/more_item_widget.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late User user;
  @override
  void initState() {
    user = sharedPreferences.getUser() ?? User();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(25.r),
        child: ListView(
          children: [
            Text(
              'tapBarItemMyAccount'.tr,
              style: TextStyles.bold32(color: colors.main),
            ),
            Gaps.vGap10,
            Center(
              child: Center(
                child: Container(
                  width: 90.w,
                  height: 90.w,
                  decoration: BoxDecoration(
                    color: colors.main,
                    border: Border.all(
                      color: colors.main,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: DiffImage(
                    width: 90.w,
                    height: 90.w,
                    image: user.image ?? '',
                    userName: user.name ?? '',
                    fitType: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Gaps.vGap10,
            Text(
              user.name ?? '',
              textAlign: TextAlign.center,
              style: TextStyles.bold20(color: colors.main),
            ),
            Text(
              user.phone ?? '',
              textAlign: TextAlign.center,
              style: TextStyles.medium18(color: colors.main),
            ),
            Text(
              user.code ?? '',
              textAlign: TextAlign.center,
              style: TextStyles.medium18(color: colors.main),
            ),
            Gaps.vGap20,
            MoreItemWidget(
              onTap: () {
                Navigator.pushNamed(context, Routes.editProfileScreenRoute)
                    .then((value) {
                  if (value == true) {
                    user = sharedPreferences.getUser() ?? User();
                    setState(() {});
                  }
                });
              },
              icon: ImgAssets.editMyProfileIcon,
              title: 'editMyProfile',
            ),
            Gaps.vGap12,
            MoreItemWidget(
              onTap: () {
                shareApp;
              },
              icon: ImgAssets.myAccountsIcons,
              title: 'myAccounts',
            ),
            Gaps.vGap12,
            //-----------------
            MoreItemWidget(
              onTap: () async {
                Navigator.pushNamed(context, Routes.friendRequests);
                //--------------------get pending request
              },
              icon: ImgAssets.friendRequest,
              title: 'friendRequests',
            ),
            //--------------------
            Gaps.vGap12,
            MoreItemWidget(
              onTap: () {
                Navigator.pushNamed(context, Routes.notificationsScreenRoute);
              },
              icon: ImgAssets.myNotificationsIcon,
              title: 'notifications',
            ),
            Gaps.vGap12,
            MoreItemWidget(
              onTap: () {
                Navigator.pushNamed(context, Routes.aboutAppRoute);
              },
              icon: ImgAssets.myInfoIcon,
              title: 'about_app',
            ),
            Gaps.vGap12,
            MyDefaultButton(
              onPressed: () {
                Constants.showLoading(context);
                Future.delayed(
                  const Duration(seconds: 2),
                  () {
                    if (context.mounted) {
                      Constants.hideLoading(context);
                      BlocProvider.of<AutoLoginCubit>(context)
                          .saveUserCycle(type: UserCycle.login);
                      BlocProvider.of<AutoLoginCubit>(context)
                          .saveUserType(type: UserType.pending);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.loginScreenRoute,
                        (route) => false,
                      );
                    }
                  },
                );
              },
              btnText: 'logout',
              color: colors.baseColor,
              textColor: colors.errorColor,
              borderColor: colors.baseColor,
            ),
            Gaps.vGap40,
          ],
        ),
      ),
    );
  }

  shareApp() {
    final box = context.findRenderObject() as RenderBox?;
    var applink = Platform.isIOS
        ? 'ios link'
        : 'https://play.google.com/store/apps/details?';
    Share.share(
      "${"COOD"} \n ${"Download the app from this link"} \n $applink",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      subject: 'COOD',
    );
  }
}
