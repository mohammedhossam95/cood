import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/utils/values/img_manager.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/tags_text_form_field.dart';
import '../../../../injection_container.dart';

class ConfirmResetPasswordScreen extends StatefulWidget {
  const ConfirmResetPasswordScreen({super.key});

  @override
  ConfirmResetPasswordScreenState createState() =>
      ConfirmResetPasswordScreenState();
}

class ConfirmResetPasswordScreenState
    extends State<ConfirmResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode passwordConfirmFocus = FocusNode();
  final TextEditingController codeController = TextEditingController(text: "");
  final FocusNode codeFocus = FocusNode();
  late String? customerCode;

  bool _obscurePasswordText = true;
  bool _obscurePasswordConfirmText = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(),
      child: Scaffold(
        backgroundColor: colors.upBackGround,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // height: 0.3.sh,
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 28.w),
                    color: colors.main,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  color: colors.backGround,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gaps.vGap25,
                        Image.asset(ImageAssets.otpForgetPasswordScreenIcon),
                        Gaps.vGap16,
                        Text(
                          'modifyPassword'.tr,
                          style: TextStyles.bold24(color: colors.upBackGround),
                        ),
                      ],
                    ),
                  ),
                  Gaps.vGap100,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'new_password'.tr,
                          style: TextStyles.bold15(color: colors.main),
                        ),
                        Gaps.vGap8,
                        AppTextFormField(
                          controller: passwordController,
                          focusNode: passwordFocus,
                          textInputAction: TextInputAction.next,
                          borderColor: colors.main,
                          validatorType: ValidatorType.password,
                          labelText: 'new_password'.tr,
                          hintText: 'new_password'.tr,
                          obscureText: _obscurePasswordText,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscurePasswordText = !_obscurePasswordText;
                              });
                            },
                            child: Icon(
                              _obscurePasswordText
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: colors.textColor,
                              size: 20.r,
                            ),
                          ),
                        ),
                        Gaps.vGap25,
                        Text(
                          'confirm_new_password'.tr,
                          style: TextStyles.bold15(color: colors.main),
                        ),
                        Gaps.vGap8,
                        AppTextFormField(
                          controller: passwordConfirmController,
                          focusNode: passwordConfirmFocus,
                          textInputAction: TextInputAction.done,
                          borderColor: colors.main,
                          // validatorType: ValidatorType.confirmPassword,
                          labelText: 'confirm_new_password'.tr,
                          hintText: 'confirm_new_password'.tr,
                          obscureText: _obscurePasswordConfirmText,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscurePasswordConfirmText =
                                    !_obscurePasswordConfirmText;
                              });
                            },
                            child: Icon(
                              _obscurePasswordConfirmText
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: colors.textColor,
                              size: 20.r,
                            ),
                          ),
                        ),
                        Gaps.vGap40,
                        MyDefaultButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() ||
                                passwordController ==
                                    passwordConfirmController) {
                              _formKey.currentState!.save();
                              Navigator.pushNamed(
                                  context, Routes.successChangePassRoute);
                            }
                          },
                          btnText: 'saveNewPassword',
                          borderColor: colors.main,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  unFocus() {
    passwordFocus.unfocus();
    passwordConfirmFocus.unfocus();
  }
}
