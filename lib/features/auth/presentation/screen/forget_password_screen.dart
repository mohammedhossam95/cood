import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/config/routes/app_routes.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/validator.dart';
import '../../../../core/utils/values/img_manager.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/gaps.dart';
import '../../../../core/widgets/tags_text_form_field.dart';
import '../../../../injection_container.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocus = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gaps.vGap40,
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
                        margin: EdgeInsets.only(top: 20.h),
                        decoration: BoxDecoration(
                          color: colors.main,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.vGap20,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Image.asset(
                    ImageAssets.forgetImageScreen,
                  ),
                ),
                Gaps.vGap50,
                Text(
                  'recover_your_password'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyles.bold20(
                    color: colors.main,
                  ),
                ),
                Gaps.vGap30,
                AppTextFormField(
                  backgroundColor: colors.upBackGround,
                  controller: phoneController,
                  focusNode: phoneFocus,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  isPhone: false,
                  validatorType: ValidatorType.phone,
                  hintText: 'phone_number'.tr,
                  borderColor: colors.main,
                ),
                Gaps.vGap22,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 52.w),
                  child: MyDefaultButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.pushNamed(context, Routes.otpAuthRoute);
                      }
                    },
                    btnText: 'recover_link',
                    borderColor: colors.main,
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
