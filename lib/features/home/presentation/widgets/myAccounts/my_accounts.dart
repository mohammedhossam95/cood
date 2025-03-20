// ignore_for_file: must_be_immutable, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/widgets/app_divider.dart';
import 'package:cood/core/widgets/error_text.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/core/widgets/show_dialog.dart';
import 'package:cood/features/categories/presentation/widgets/my_progress.dart';
import 'package:cood/features/home/domain/entities/all_social_media_entity.dart';
import 'package:cood/features/home/domain/entities/user_social_media_entity.dart';
import 'package:cood/features/home/presentation/cubit/get_all_social_media/get_All_social_media_state.dart';
import 'package:cood/features/home/presentation/cubit/get_all_social_media/get_all_social_media_cubit.dart';
import 'package:cood/features/home/presentation/cubit/get_user_social_media/get_user_social_media_cubit.dart';
import 'package:cood/features/home/presentation/cubit/get_user_social_media/get_user_social_media_state.dart';
import 'package:cood/features/home/presentation/widgets/myAccounts/all_social_media_container_item.dart';
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
              child:
                  BlocBuilder<GetUserSocialMediaCubit, GetUserSocialMediaState>(
                builder: (context, state) {
                  if (state is GetUserSocialMediaLoading) {
                    return const Center(
                      child: MyProgrees(),
                    );
                  } else if (state is GetUserSocialMediaSuccess) {
                    List<SocialMediaEntity> sociaAccounts =
                        state.response.data as List<SocialMediaEntity>;
                    return sociaAccounts.isNotEmpty
                        ? SocialAccounts(
                            //ToDo when color added in response
                            socialAccounts: sociaAccounts,
                            socialBackgroundColors: socialBacgroundColors,
                            socialPhotoColors: socialPhotoColors,
                          )
                        : ErrorText(
                            width: ScreenUtil().screenWidth,
                            text: 'noData'.tr,
                          );
                  } else if (state is GetUserSocialMediaFailure) {
                    return ErrorText(
                      width: ScreenUtil().screenWidth,
                      text: state.errorMessage,
                    );
                  } else {
                    return SizedBox();
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
                    onPressed: () async {
                      await context
                          .read<GetAllSocialMediaCubit>()
                          .getAllSocialMedia();
                      // ignore: use_build_context_synchronously
                      addAccountButton(context);
//---------------------------------/end dialog
                    },
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

  addAccountButton(BuildContext context) => showAppDialog(
        borderRadius: 30.0.r,
        horizontalPadding: 0.0,
        verticalPadding: 0.0,
        context: context,
        child: Container(
          height: 590.0.h,
          width: 393.0.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: MyColors.lightBlue,
          ),
          //-------------------show dialo
          child: ShowAllAccountsDialog(),
        ),
      );
}

class ShowAllAccountsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gaps.vGap20,
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: AppDivider(
            width: 56.w,
            height: 2.h,
          ),
        ),
        Gaps.vGap10,
        Text(
          'link_other_accounts'.tr,
          style: TextStyle(
            color: MyColors.main,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.vGap10,
        AppDivider(
          width: 246.w,
          height: 2.h,
          color: MyColors.main,
        ),
        Gaps.vGap20,
        Expanded(
          child: Container(
            height: 474.0.h,
            width: 378.0.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: MyColors.white,
            ),
            child: BlocBuilder<GetAllSocialMediaCubit, GetAllSocialMediaState>(
              builder: (context, state) {
                if (state is GetAllSocialMediaLoading) {
                  return const Center(
                    child: MyProgrees(),
                  );
                } else if (state is GetAllSocialMediaSuccerss) {
                  List<AllSocialMediaEntity> allsocialMedia =
                      state.response.data as List<AllSocialMediaEntity>;

                  //-----------------show social media
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: allsocialMedia.length,
                    itemBuilder: (context, index) {
                      return AllSocialContainerItem(
                        allSocialAccount: allsocialMedia[index],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(' please try again !'),
                  );
                }
              },
            ),
          ),
        ),
        Gaps.vGap20,
        MyDefaultButton(
          onPressed: () {
            Navigator.pop(context);
          },
          height: 44.h,
          width: 128.w,
          btnText: "save",
        ),
        Gaps.vGap20,
      ],
    );
  }
}
