// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '/config/routes/app_routes.dart';
import '/core/utils/constants.dart';
import '/core/utils/values/svg_manager.dart';
import '/core/widgets/gaps.dart';
import '/features/more/presentation/widgets/language_setting_widget.dart';
import '/features/more/presentation/widgets/more_item_widget.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25.r),
      child: Column(
        children: [
          Gaps.vGap50,
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
          Gaps.vGap20,
          Text(
            'فهد سليمان',
            style: TextStyles.regular15(),
          ),
          Gaps.vGap8,
          Text(
            '+966 55 555 5555',
            style: TextStyles.regular12(),
          ),
          Gaps.vGap8,
          Text(
            '12345675555',
            style: TextStyles.regular12(),
          ),
          Gaps.vGap16,
          MoreItemWidget(
            onTap: () {
              Constants.buildCustomShowModel(
                context: context,
                child: const LanguageSettingWidget(),
              );
            },
            icon: SvgAssets.changLanguage,
            title: 'change_lang',
          ),
          Gaps.vGap12,
          MoreItemWidget(
            onTap: () {
              shareApp;
            },
            icon: SvgAssets.shareApp,
            title: 'share_app',
          ),
          Gaps.vGap12,
          MoreItemWidget(
            onTap: () {
              Navigator.pushNamed(context, Routes.contactUsRoute);
            },
            icon: SvgAssets.contactUs,
            title: 'contact_us',
          ),
          Gaps.vGap12,
          MoreItemWidget(
            onTap: () {
              Navigator.pushNamed(context, Routes.termsAndConditionsRoute);
            },
            icon: SvgAssets.terms,
            title: 'terms_and_conditions',
          ),
          Gaps.vGap12,
          MoreItemWidget(
            onTap: () {
              Navigator.pushNamed(context, Routes.privacyPolicyRoute);
            },
            icon: SvgAssets.privacy,
            title: 'privacy_policy',
          ),
        ],
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
