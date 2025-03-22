import 'dart:io';

import 'package:cood/config/routes/app_routes.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/features/auth/presentation/widgets/custom_back_icon.dart';
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
        appBar: AppBar(
          backgroundColor: colors.backGround,
          title: Text(
            'editMyProfile'.tr,
            style: TextStyles.bold20(color: colors.main),
          ),
          elevation: 0,
          leading: CustomBack(),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap78,
                Center(
                  child: ProfileImage(
                    image: '',
                    updateBannerImage: (f) {},
                  ),
                ),
                Gaps.vGap45,
                Text(
                  'name'.tr,
                  style: TextStyles.bold14(color: colors.main),
                ),
                Gaps.vGap10,
                AppTextFormField(
                  controller: phoneNumberController,
                  focusNode: phoneNumberFocus,
                  hintText: 'name'.tr,
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
                  hintText: 'phone_number'.tr,
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
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
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
      ),
    );
  }
}
