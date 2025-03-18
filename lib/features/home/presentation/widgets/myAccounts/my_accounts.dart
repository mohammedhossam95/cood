// ignore_for_file: must_be_immutable

import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/features/categories/presentation/widgets/my_progress.dart';
import 'package:cood/features/home/domain/entities/user_social_media_entity.dart';
import 'package:cood/features/home/presentation/cubit/get_user_social_media/get_user_social_media_cubit.dart';
import 'package:cood/features/home/presentation/cubit/get_user_social_media/get_user_social_media_state.dart';
import 'package:cood/features/home/presentation/widgets/myAccounts/social_accounts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySocialAccounts extends StatelessWidget {
  MySocialAccounts({super.key});
  List<Color> socialPhotoColors = [
    MyColors.main,
    MyColors.black,
    MyColors.socialYellow,
    MyColors.socialGreen,
  ];
  List<Color> socialBacgroundColors = [
    MyColors.facbookItemColor,
    MyColors.tikokItemColor,
    MyColors.snapShatItemColor,
    MyColors.whatsAppItemColor,
  ];



  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              child: BlocBuilder<GetUserSocialMediaCubit, GetUserSocialMediaState>(
                builder: (context, state) {
                  if (state is GetUserSocialMediaLoading) {
                    return const Center(
                      child: MyProgrees(),
                    );
                  }
                  else if (state is GetUserSocialMediaSuccerss) {
                    List<SocialMediaEntity> sociaAccounts =
                        state.response.data as List<SocialMediaEntity>;
                    return SocialAccounts(
                      socialAccounts: sociaAccounts,
                      socialBackgroundColors: socialBacgroundColors,
                      socialPhotoColors: socialPhotoColors,
                    );
                  }else{
                    return const Center(
                    child: Text(' please try again !'),
                  );
                  }
                  
                },
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
