import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/widgets/country_code_widget.dart';
import '/core/widgets/my_default_button.dart';
import '/features/auth/presentation/screen/register/new_user_register_screen.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../core/utils/values/text_styles.dart';
import '../../../../../core/widgets/gaps.dart';
import '../../../../../core/widgets/profile_image.dart';
import '../../../../../core/widgets/tags_text_form_field.dart';
import '../../../../../injection_container.dart';
import '../../../domain/usecases/landery_register_use_case.dart';

class NewWasherRegisterScreen extends StatefulWidget {
  const NewWasherRegisterScreen({super.key});

  @override
  State<NewWasherRegisterScreen> createState() =>
      _NewWasherRegisterScreenState();
}

class _NewWasherRegisterScreenState extends State<NewWasherRegisterScreen> {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController userNameController = TextEditingController();
  FocusNode userNameFocus = FocusNode();
  TextEditingController phoneController = TextEditingController();
  FocusNode phoneFocus = FocusNode();
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  File? laundryImageFile;
  Country selcCountry = Country(
    phoneCode: '966',
    countryCode: 'SA',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Saudi Arabia',
    example: '512345678',
    displayName: 'Saudi Arabia (SA) [+966]',
    displayNameNoCountryCode: 'Saudi Arabia (SA)',
    e164Key: '966-SA-0',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.baseColor,
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'new_register'.tr,
            style: TextStyles.regular16(),
          ),
        ),
        body: Form(
          key: formState,
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AmrLinearProgressIndecatorWidget(
                          linearValue: 1 / 3,
                        ),
                        Gaps.vGap20,
                        AmrTheFristMessageRegisterWidget(
                          itemTitel: 'frist_step'.tr,
                          itemSubTitel: 'frist_step_details'.tr,
                        ),
                        Gaps.vGap40,
                        Text(
                          'laundry_image'.tr,
                          style: TextStyles.bold16(),
                        ),
                        Gaps.vGap15,
                        ProfileImage(
                          updateBannerImage: (img) {
                            setState(() {
                              laundryImageFile = img;
                            });
                          },
                        ),
                        Gaps.vGap15,
                        Text(
                          'new_user_name'.tr,
                          style: TextStyles.bold16(),
                        ),
                        Gaps.vGap15,
                        AppTextFormField(
                          controller: userNameController,
                          focusNode: userNameFocus,
                          hintText: 'new_user_name'.tr,
                          textInputAction: TextInputAction.next,
                          validatorType: ValidatorType.standard,
                        ),
                        Gaps.vGap25,
                        Text(
                          'phone'.tr,
                          style: TextStyles.bold16(),
                        ),
                        Gaps.vGap15,
                        Row(
                          children: [
                            CountryCodeWidget(
                              country: selcCountry,
                              updateValue: (Country value) {
                                setState(() {
                                  selcCountry = value;
                                });
                              },
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: AppTextFormField(
                                controller: phoneController,
                                focusNode: phoneFocus,
                                hintText: 'phone'.tr,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                validatorType: ValidatorType.phone,
                              ),
                            ),
                          ],
                        ),
                        Gaps.vGap25,
                        Text(
                          'new_email_address'.tr,
                          style: TextStyles.bold16(),
                        ),
                        Gaps.vGap15,
                        AppTextFormField(
                          controller: emailController,
                          focusNode: emailFocus,
                          hintText: 'new_email_address'.tr,
                          textInputAction: TextInputAction.done,
                          validatorType: ValidatorType.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        Gaps.vGap40,
                      ],
                    ),
                  ),
                ),
                MyDefaultButton(
                  onPressed: () async {
                    if (formState.currentState!.validate()) {
                      formState.currentState!.save();
                      try {
                        String? phoneNum = await Constants.phoneParsing(
                          phone: phoneController.text,
                          countryCode: selcCountry.countryCode,
                        );

                        if (phoneNum != null) {
                          if (laundryImageFile != null) {
                            Future.delayed(Duration.zero, () {
                              if (!context.mounted) return;
                              Navigator.pushNamed(
                                context,
                                Routes.newWasherRegisterSecondStepRoute,
                                arguments: LanderyRegisterParams(
                                    userName: userNameController.text,
                                    phone: phoneNum,
                                    email: emailController.text,
                                    file: laundryImageFile),
                              );
                            });
                          } else {
                            Future.delayed(Duration.zero, () {
                              if (!context.mounted) return;
                              Constants.showSnakToast(
                                type: 2,
                                context: context,
                                message: 'pickCorrectPhoto'.tr,
                              );
                            });
                          }
                        } else {
                          if (!context.mounted) return;
                          Constants.showSnakToast(
                            type: 2,
                            context: context,
                            message: 'invalidPhoneText'.tr,
                          );
                        }
                      } on PlatformException catch (e) {
                        debugPrint(e.toString());

                        if (!context.mounted) return;
                        Constants.showSnakToast(
                          type: 2,
                          context: context,
                          message: 'invalidPhoneText'.tr,
                        );
                      }
                    }
                  },
                  btnText: 'next',
                ),
                SizedBox(
                  height: ScreenUtil().screenHeight * .01,
                )
              ],
            ),
          ),
        ));
  }
}
