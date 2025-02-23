import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/config/routes/app_routes.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/validator.dart';
import '../../../../core/utils/values/assets.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/tags_text_form_field.dart';
import '../../../../injection_container.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  FocusNode currentPasswordFocus = FocusNode();
  TextEditingController newPasswordController = TextEditingController();
  FocusNode newPasswordFocus = FocusNode();
  TextEditingController confirmNewPasswordController = TextEditingController();
  FocusNode confirmNewPasswordFocus = FocusNode();
  bool isSecured = true;
  bool isSecured1 = true;
  bool isSecured2 = true;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.backGround,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
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
                              'changePassword'.tr,
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
                  Gaps.vGap47,
                  Center(child: Image.asset(ImgAssets.changePasswordImage)),
                  Gaps.vGap20,
                  Text(
                    'currentPassword'.tr,
                    style: TextStyles.bold16(color: colors.main),
                  ),
                  AppTextFormField(
                    backgroundColor: colors.upBackGround,
                    controller: currentPasswordController,
                    focusNode: currentPasswordFocus,
                    hintText: 'currentPassword'.tr,
                    obscureText: isSecured,
                    textInputAction: TextInputAction.next,
                    validatorType: ValidatorType.password,
                    borderColor: colors.main,
                    suffixIcon: isSecured == true
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                isSecured = !isSecured;
                              });
                            },
                            icon: Icon(
                              Icons.visibility,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                isSecured = !isSecured;
                              });
                            },
                            icon: Icon(
                              Icons.visibility_off,
                            ),
                          ),
                  ),
                  Gaps.vGap11,
                  Text(
                    'newPassword'.tr,
                    style: TextStyles.bold16(color: colors.main),
                  ),
                  AppTextFormField(
                    backgroundColor: colors.upBackGround,
                    controller: newPasswordController,
                    focusNode: newPasswordFocus,
                    hintText: 'newPassword'.tr,
                    obscureText: isSecured1,
                    textInputAction: TextInputAction.next,
                    // validatorType: ValidatorType.password,
                    borderColor: colors.main,
                    suffixIcon: isSecured1 == true
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                isSecured1 = !isSecured1;
                              });
                            },
                            icon: Icon(
                              Icons.visibility,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                isSecured1 = !isSecured1;
                              });
                            },
                            icon: Icon(
                              Icons.visibility_off,
                            ),
                          ),
                  ),
                  Gaps.vGap11,
                  Text(
                    'confirmNewPassword'.tr,
                    style: TextStyles.bold16(color: colors.main),
                  ),
                  AppTextFormField(
                    backgroundColor: colors.upBackGround,
                    controller: confirmNewPasswordController,
                    focusNode: confirmNewPasswordFocus,
                    hintText: 'confirmNewPassword'.tr,
                    obscureText: isSecured2,
                    textInputAction: TextInputAction.done,
                    // validatorType: ValidatorType.confirmPassword,
                    borderColor: colors.main,
                    suffixIcon: isSecured2 == true
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                isSecured2 = !isSecured2;
                              });
                            },
                            icon: Icon(
                              Icons.visibility,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                isSecured2 = !isSecured2;
                              });
                            },
                            icon: Icon(
                              Icons.visibility_off,
                            ),
                          ),
                  ),
                  Gaps.vGap32,
                  MyDefaultButton(
                    onPressed: () {
                      setState(() {
                        
                      });
                      if(formKey.currentState!.validate()){
                        formKey.currentState!.save();
                        Navigator.pushNamed(context, Routes.successChangePassRoute);
                      }
                    },
                    btnText: 'saveNewPassword',
                    borderColor: colors.main,
                    color: newPasswordController.text ==
                            confirmNewPasswordController.text
                        ? colors.main
                        : colors.textColor.withValues(alpha: .4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
