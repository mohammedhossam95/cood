// ignore_for_file: must_be_immutable

import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/features/home/domain/entities/social_entity.dart';
import 'package:cood/features/home/presentation/widgets/myAccounts/social_accounts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySocialAccounts extends StatelessWidget {
   MySocialAccounts({super.key});
    List<Color> socialPhotoColors = [
    MyColors.main,
    MyColors.socialGreen,
    MyColors.black,
    MyColors.socialYellow,
    MyColors.black,
    MyColors.socialYellow,
  ];
  List<Color> socialBacgroundColors = [
    MyColors.facbookItemColor,
    MyColors.whatsAppItemColor,
    MyColors.tikokItemColor,
    MyColors.snapShatItemColor,
    MyColors.tikokItemColor,
    MyColors.snapShatItemColor,
  ];

  List<SocialEntity> sociaAccounts = [
    SocialEntity(
        name: 'Andrew Tate',
        email: 'Andrewtate25235@hotmail.com',
        image: 'assets/images/facbook.png'),
    SocialEntity(
        name: 'Andrew Tate',
        email: '+966599697364',
        image: 'assets/images/Whatsapp 1.png'),
    SocialEntity(
        name: '@AndrewTate',
        email: 'Andrewtate@hotmail.com',
        image: 'assets/images/tiktok.png'),
    SocialEntity(
        name: '@AndrewTate',
        email: 'Andrewtate@hotmail.com',
        image: 'assets/images/snapchat.png'),
    SocialEntity(
        name: '@AndrewTate',
        email: 'Andrewtate@hotmail.com',
        image: 'assets/images/snapchat.png'),
    SocialEntity(
        name: '@AndrewTate',
        email: 'Andrewtate@hotmail.com',
        image: 'assets/images/snapchat.png'),        
  ];

  @override
  Widget build(BuildContext context) {
  return  Expanded(
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: MyColors.upBackGround,
                borderRadius: BorderRadius.circular(25.r),
                boxShadow: [
                  BoxShadow(
                    color: MyColors.body.withValues(alpha: .5), // Shadow color
                    spreadRadius: 2.r, // Spread radius
                    blurRadius: 10.r, // Blur radius
                    offset: Offset(0, 3), // Offset in x and y directions
                  ),
                ],
              ),
              child: SocialAccounts(
                socialAccounts: sociaAccounts,
                socialBackgroundColors: socialBacgroundColors,
                socialPhotoColors: socialPhotoColors,
              ),
            ),
          ),
          Gaps.vGap20,
              //-----------------4
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10.h),
                      child: MyDefaultButton(
                        onPressed: () {},
                        height: 50.h,
                        btnText: "link_other_accounts",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10.h),
                      child: MyDefaultButton(
                        onPressed: () {},
                        height: 50.h,
                        btnText: "communication_channels",
                      ),
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
