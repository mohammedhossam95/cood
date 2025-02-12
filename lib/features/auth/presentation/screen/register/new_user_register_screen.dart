import 'dart:io';

import 'package:cood/config/routes/app_routes.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/enums.dart';
import '/core/utils/values/assets.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/tags_text_form_field.dart';
import '/injection_container.dart';
import '../../../../../core/utils/validator.dart';
import '../../widgets/country_code_widget.dart';

class NewUserRegisterScreen extends StatefulWidget {
  const NewUserRegisterScreen({super.key});

  @override
  State<NewUserRegisterScreen> createState() => _NewUserRegisterScreenState();
}

class _NewUserRegisterScreenState extends State<NewUserRegisterScreen> {
  final GlobalKey<FormState> formState = GlobalKey();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController configPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode userNameFocus = FocusNode();
  final FocusNode configPasswordFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocus = FocusNode();

  bool isSecured = true;
  bool isSecured1 = true;

  // final ImagePicker _picker = ImagePicker();
  File? avatarImageFile;
  Country selcCountry = Country(
    phoneCode: '20',
    countryCode: 'EG',
    e164Sc: 0,
    geographic: true,
    level: -1,
    name: 'Egypt',
    example: '1001234567',
    displayName: 'Egypt (EG) [+20]',
    displayNameNoCountryCode: 'Egypt (EG)',
    e164Key: '20-EG-0',
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(),
      child: Scaffold(
        backgroundColor: colors.backGround,
        body: Form(
          key: formState,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gaps.vGap100,
                  Gaps.vGap100,
                  Image.asset(
                    ImgAssets.jzlLogo,
                  ),
                  Gaps.vGap78,
                  Text(
                    'welcomphrase'.tr,
                    style: TextStyles.bold24(color: colors.main),
                  ),
                  Gaps.vGap5,
                  Text(
                    'enterAcountInformation'.tr,
                    style: TextStyles.bold24(color: colors.main),
                  ),
                  Gaps.vGap12,
                  AppTextFormField(
                    controller: userNameController,
                    focusNode: userNameFocus,
                    hintText: 'new_user_name'.tr,
                    textInputAction: TextInputAction.next,
                    validatorType: ValidatorType.name,
                    borderColor: colors.main,
                  ),
                  Gaps.vGap25,
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFormField(
                          controller: configPasswordController,
                          focusNode: configPasswordFocus,
                          hintText: 'phone'.tr,
                          textInputAction: TextInputAction.next,
                          validatorType: ValidatorType.phone,
                          borderColor: colors.main,
                        ),
                      ),
                      CountryCodeWidget(
                        country: selcCountry,
                        updateValue: (Country value) {
                          setState(() {
                            selcCountry = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Gaps.vGap15,
                  AppTextFormField(
                    backgroundColor: colors.upBackGround,
                    controller: passwordController,
                    focusNode: passwordFocus,
                    hintText: 'password'.tr,
                    obscureText: isSecured,
                    textInputAction: TextInputAction.done,
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
                  Gaps.vGap15,
                  AppTextFormField(
                    backgroundColor: colors.upBackGround,
                    controller: configPasswordController,
                    focusNode: configPasswordFocus,
                    hintText: 'configPassword'.tr,
                    obscureText: isSecured,
                    textInputAction: TextInputAction.done,
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
                  Gaps.vGap8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'accept'.tr,
                              style: TextStyles.regular12(
                                  color: colors.blackColor),
                            ),
                            TextSpan(text: ' '),
                            TextSpan(
                              text: 'policyAndTerms'.tr,
                              style: TextStyles.regular14(color: colors.main),
                            ),
                            TextSpan(
                              text: ' .',
                              style: TextStyles.regular12(
                                  color: colors.blackColor),
                            ),
                          ],
                        ),
                      ),
                      Gaps.hGap4,
                      InkWell(
                        onTap:(){
                          Navigator.pushNamed(context, Routes.tearmsAndCondationsAuthScreenRoute);
                        },
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Container(
                              width: 30.w,
                              height: 9.h,
                              decoration: BoxDecoration(
                                  color: colors.textColor.withValues(alpha: .3),
                                  borderRadius: BorderRadius.circular(10.r)),
                            ),
                            Container(
                              height: 25.h,
                              width: 17.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors.textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gaps.vGap25,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 90.w),
                    child: MyDefaultButton(
                      borderColor: colors.main,
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.otpAuthRoute);
                      },
                      btnText: 'createAccount',
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
    userNameFocus.unfocus();
    configPasswordFocus.unfocus();
    passwordFocus.unfocus();
    // phoneFocus.unfocus();
  }
}

class AmrTheFristMessageRegisterWidget extends StatelessWidget {
  final String itemTitel;
  final String itemSubTitel;

  const AmrTheFristMessageRegisterWidget({
    super.key,
    required this.itemTitel,
    required this.itemSubTitel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 63.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.shade100,
      ),
      child: Row(
        children: [
          SvgPicture.asset(ImgAssets.deliveryImage),
          Gaps.hGap16,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemTitel,
                style: TextStyles.regular16(),
              ),
              Text(
                itemSubTitel,
                style: TextStyles.regular14(),
              )
            ],
          )
        ],
      ),
    );
  }
}

class AmrLinearProgressIndecatorWidget extends StatelessWidget {
  final double linearValue;
  final bool isCanceled;
  final String? status;

  const AmrLinearProgressIndecatorWidget({
    super.key,
    required this.linearValue,
    this.isCanceled = false,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(status != null
          ? getColor(status)
          : isCanceled
              ? Colors.red
              : Colors.blue),
      value: linearValue,
      minHeight: 10.h,
      borderRadius: BorderRadius.all(Radius.circular(5.r)),
    );
  }

  Color getColor(status) {
    return status == MyOrderStatus.pending.value
        ? Colors.yellow
        : status == MyOrderStatus.completed.value
            ? Colors.green
            : status == MyOrderStatus.canceled.value ||
                    status == MyOrderStatus.refuseDelegate.value
                ? Colors.red
                : Colors.orangeAccent;
  }
}
