import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/values/svg_manager.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
import '/core/widgets/tags_text_form_field.dart';
import '/features/profile/presentation/widgets/image_picker_widget.dart';
import '/injection_container.dart';

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
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final TextEditingController passportController = TextEditingController();
  final FocusNode passportFocus = FocusNode();
  final TextEditingController licenseController = TextEditingController();
  final FocusNode licenseFocus = FocusNode();
  File? passportImage;
  File? licenseImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: colors.main),
        centerTitle: true,
        title: SvgPicture.asset(SvgAssets.profile),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'edit'.tr,
              style: TextStyles.regular14(color: colors.secondary),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'mobile_number'.tr,
              style: TextStyles.semiBold14(color: colors.main),
            ),
            Gaps.vGap10,
            AppTextFormField(
                controller: phoneNumberController,
                focusNode: phoneNumberFocus,
                hintText: 'xxxxxxxxxx'),
            Gaps.vGap12,
            Text(
              'username'.tr,
              style: TextStyles.semiBold14(color: colors.main),
            ),
            Gaps.vGap10,
            AppTextFormField(
                controller: usernameController,
                focusNode: usernameFocus,
                hintText: 'xxxxxxxxxx'),
            Gaps.vGap12,
            Text(
              'email'.tr,
              style: TextStyles.semiBold14(color: colors.main),
            ),
            Gaps.vGap10,
            AppTextFormField(
                controller: emailController,
                focusNode: emailFocus,
                hintText: 'xxxxxxxxxx'),
            Gaps.vGap12,
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colors.dividerColor, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'passport_or_id_photo'.tr,
                        style: TextStyles.semiBold14(color: colors.main),
                      ),
                      Gaps.hGap4,
                      Text(
                        'optional'.tr,
                        style: TextStyles.semiBold14(color: colors.secondary),
                      ),
                      const Spacer(),
                      SvgPicture.asset(SvgAssets.upload),
                    ],
                  ),
                  Gaps.vGap10,
                  ImagePickerWidget(
                    updateBannerImage: (image) {
                      setState(() {
                        passportImage = image;
                      });
                    },
                  )
                ],
              ),
            ),
            Gaps.vGap12,
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colors.dividerColor, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'driver_license_photo'.tr,
                        style: TextStyles.semiBold14(color: colors.main),
                      ),
                      Gaps.hGap4,
                      Text(
                        'optional'.tr,
                        style: TextStyles.semiBold14(color: colors.secondary),
                      ),
                      const Spacer(),
                      SvgPicture.asset(SvgAssets.upload),
                    ],
                  ),
                  Gaps.vGap10,
                  ImagePickerWidget(
                    updateBannerImage: (image) {
                      setState(() {
                        licenseImage = image;
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20.0),
        child: MyDefaultButton(
          btnText: 'save',
          onPressed: () {},
          color: colors.secondary,
        ),
      ),
    );
  }
}
