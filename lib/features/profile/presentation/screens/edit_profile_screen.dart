import 'dart:io';

import 'package:cood/config/routes/app_routes.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/tags_text_form_field.dart';
import '/injection_container.dart';
import '../../../../core/widgets/profile_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final FocusNode phoneNumberFocus = FocusNode();
  final TextEditingController usernameController = TextEditingController();
  final FocusNode usernameFocus = FocusNode();

  File? passportImage;
  File? licenseImage;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.backGround,
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'editMyProfile'.tr,
                          style: TextStyles.bold20(color: colors.main),
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
              Gaps.vGap78,
              Center(child: ProfileImage()),
              Gaps.vGap45,
              Text(
                'name'.tr,
                style: TextStyles.bold14(color: colors.main),
              ),
              Gaps.vGap10,
              AppTextFormField(
                controller: phoneNumberController,
                focusNode: phoneNumberFocus,
                hintText: 'فهد سليمان',
                borderColor: colors.main,
              ),
              Gaps.vGap12,
              Text(
                'phone_number'.tr,
                style: TextStyles.bold14(color: colors.main),
              ),
              Gaps.vGap10,
              AppTextFormField(
                controller: usernameController,
                focusNode: usernameFocus,
                hintText: '+966562485527',
                borderColor: colors.main,
              ),
              Gaps.vGap30,
              MyDefaultButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.changePasswordRoute);
                },
                btnText: 'changePassword',
                borderColor: colors.baseColor,
                color: colors.baseColor,
                textStyle: TextStyles.bold14(
                  color: colors.blackColor,
                ),
              ),
              Gaps.vGap50,
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 60.w),
                child: MyDefaultButton(
                  
                  onPressed: () {},
                  btnText: 'saveChanges',
                  borderColor: colors.main,
                  color: colors.main,
                  textStyle: TextStyles.bold17(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
