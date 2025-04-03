// ignore_for_file: unnecessary_brace_in_string_interps, sized_box_for_whitespace, deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/app_divider.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/core/widgets/show_dialog.dart';
import 'package:cood/features/categories/presentation/cubit/post_selected_category_cubit/post_selected_category_cubit.dart';
import 'package:cood/features/categories/presentation/cubit/post_selected_category_cubit/post_selected_category_state.dart';
import 'package:cood/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showConfirmatioAlert(context,
        {required dynamic confirmYes,
        String? nameAr,
        String? nameEn,
        bool isArabic = true,
        required dynamic confirmNo}) =>
    showAppDialog(
      context: context,
      borderRadius: 20.r,
      child: ZoomIn(
         duration:
          const Duration(milliseconds: 500), // Customize animation duration
        child: Container(
          height: 170.h,
          width: 320.w,
          decoration: BoxDecoration(
            color: colors.backGround,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            
            children: [
              Gaps.vGap10,
              AppDivider(
                width: 50.w,
                height: 2.h,
              ),
              Gaps.vGap5,
              FadeInUp(
                child: Text(
                  'communication_channels'.tr,
                  style: TextStyles.bold18(
                    color: colors.main,
                  ),
                ),
              ),
              Gaps.vGap5,
              AppDivider(
                width: 250.w,
                height: 2.h,
              ),
              Gaps.vGap5,
              FadeInDown(
                child: Container(
                  alignment: Alignment.topCenter,
                  //padding: EdgeInsets.symmetric(horizontal: 2.0.h),
                  height: 50.h,
                  child:  (isArabic)?Text(
                      'هل بالفعل تريد الانضمام الي ${nameAr}؟',
                      style: TextStyles.semiBold14(
                        color: colors.main,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ):Center(
                      child: Text(
                        ' ?Did you want to join ${nameEn} ',
                        style: TextStyles.semiBold14(
                          color: colors.main,
                        ),
                          maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  
                ),
              ),
              //Gaps.vGap10,
              BlocBuilder<PostSelectedCategoryCubit, PostSelectedCategoryState>(
                builder: (context, state) {
                  if (state is PostSelectedCategoryLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FadeInLeft(
                          child: MyDefaultButton(
                            width: 120.w,
                            height: 40.h,
                            onPressed: confirmYes,
                            btnText: 'yes',
                          ),
                        ),
                        FadeInRight(
                          child: MyDefaultButton(
                            width: 120.w,
                            height: 40.h,
                            onPressed: confirmNo,
                            btnText: 'no',
                            color: colors.main.withOpacity(0.5),
                            borderColor: colors.main,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              Gaps.vGap10,
            ],
          ),
        ),
      ),
    );
