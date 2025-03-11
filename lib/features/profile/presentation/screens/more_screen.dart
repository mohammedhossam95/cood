// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/diff_img.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/features/auth/domain/entities/login_response.dart';
import 'package:cood/injection_container.dart';
import 'package:flutter/material.dart';
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
            Gaps.vGap20,
            Center(
              child: Center(
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    color: colors.main,
                    border: Border.all(
                      color: colors.main,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: DiffImage(
                    width: 100.w,
                    height: 100.w,
                    image: '',
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
            Gaps.vGap30,
            MoreItemWidget(
              onTap: () {
                Navigator.pushNamed(context, Routes.editProfileScreenRoute);
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
              onPressed: () {},
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
