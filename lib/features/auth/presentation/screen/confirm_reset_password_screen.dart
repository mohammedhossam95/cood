import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/utils/values/assets.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/text_form_field.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.vGap90,
                  Center(child: Image.asset(ImgAssets.imagesLogoAr)),
                  Gaps.vGap50,
                  Text(
                    'rechange_password'.tr,
                    style: TextStyles.bold15(),
                  ),
                  Gaps.vGap25,
                  Text(
                    'new_password'.tr,
                    style: TextStyles.bold15(),
                  ),
                  Gaps.vGap15,
                  AppTextFormField(
                    controller: passwordController,
                    focusNode: passwordFocus,
                    textInputAction: TextInputAction.next,
                    validatorType: ValidatorType.password,
                    labelText: 'new_password'.tr,
                    hintText: 'new_password'.tr,
                    obscureText: _obscurePasswordText,
                    suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscurePasswordText = !_obscurePasswordText;
                        });
                      },
                      child: FaIcon(
                        _obscurePasswordText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 16.r,
                      ),
                    ),
                  ),
                  Gaps.vGap25,
                  Text(
                    'confirm_new_password'.tr,
                    style: TextStyles.bold15(),
                  ),
                  Gaps.vGap15,
                  AppTextFormField(
                    controller: passwordConfirmController,
                    focusNode: passwordConfirmFocus,
                    textInputAction: TextInputAction.done,
                    // validatorType: ValidatorType.confirmPassword,
                    labelText: 'confirm_new_password'.tr,
                    hintText: 'confirm_new_password'.tr,
                    obscureText: _obscurePasswordConfirmText,
                    suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscurePasswordConfirmText =
                              !_obscurePasswordConfirmText;
                        });
                      },
                      child: FaIcon(
                        _obscurePasswordConfirmText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 16.r,
                      ),
                    ),
                  ),
                  Gaps.vGap40,
                  MyDefaultButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.pushNamed(
                            context, Routes.successChangePassRoute);
                      }
                    },
                    btnText: 'confirm_button',
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
