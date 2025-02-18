// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '/config/routes/app_routes.dart';
import '/core/widgets/gaps.dart';
import '/features/more/presentation/widgets/more_item_widget.dart';
import '../../../../core/utils/values/assets.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(25.r),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'tapBarItemMyAccount'.tr,
                        style: TextStyles.bold32(color: colors.main),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40.h,
                    width: 40.w,
                    margin: EdgeInsets.only(top: 20.h),
                    decoration: BoxDecoration(
                      color: colors.textColor.withValues(alpha: .3),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ),
                ),
              ],
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      "assets/images/user.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Gaps.vGap10,
            Text(
              'فهد سليمان',
              style: TextStyles.bold20(color: colors.main),
            ),
            Text(
              '+966 55 555 5555',
              style: TextStyles.bold20(color: colors.main),
            ),
            Text(
              '12345675555',
              style: TextStyles.bold20(color: colors.main),
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
                Navigator.pushNamed(context, Routes.termsAndConditionsRoute);
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
            )
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
