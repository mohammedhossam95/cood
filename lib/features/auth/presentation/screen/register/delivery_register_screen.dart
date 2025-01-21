import 'dart:async';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/widgets/gaps.dart';
import '/features/auth/domain/usecases/delivery_register_use_case.dart';
import '/features/auth/presentation/screen/register/new_user_register_screen.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../core/utils/values/text_styles.dart';
import '../../../../../core/widgets/country_code_widget.dart';
import '../../../../../core/widgets/my_default_button.dart';
import '../../../../../core/widgets/profile_image.dart';
import '../../../../../core/widgets/tags_text_form_field.dart';
import '../../../../../injection_container.dart';

class NewDeliveryRegisterScreen extends StatefulWidget {
  const NewDeliveryRegisterScreen({super.key});

  @override
  State<NewDeliveryRegisterScreen> createState() =>
      _NewDeliveryRegisterScreenState();
}

class _NewDeliveryRegisterScreenState extends State<NewDeliveryRegisterScreen> {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController userNameController = TextEditingController();
  FocusNode userNameFocus = FocusNode();
  TextEditingController phoneController = TextEditingController();
  FocusNode phoneFocus = FocusNode();
  // TextEditingController locationController = TextEditingController();
  // FocusNode locationFocus = FocusNode();

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
  File? avatarFile;

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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AmrLinearProgressIndecatorWidget(
                        linearValue: 1 / 2,
                      ),
                      Gaps.vGap20,
                      AmrTheFristMessageRegisterWidget(
                        itemTitel: 'frist_step'.tr,
                        itemSubTitel: 'frist_step_details'.tr,
                      ),
                      Gaps.vGap40,
                      Text(
                        'car_image'.tr,
                        style: TextStyles.bold16(),
                      ),
                      Gaps.vGap15,
                      ProfileImage(
                        updateBannerImage: (img) {
                          setState(() {
                            avatarFile = img;
                          });
                        },
                      ),
                      Gaps.vGap25,
                      Text(
                        'new_user_name'.tr,
                        style: TextStyles.bold16(),
                      ),
                      Gaps.vGap15,
                      AppTextFormField(
                        controller: userNameController,
                        focusNode: userNameFocus,
                        hintText: 'new_user_name'.tr,
                        labelText: 'new_user_name'.tr,
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
                          Gaps.hGap4,
                          Expanded(
                            child: AppTextFormField(
                              controller: phoneController,
                              focusNode: phoneFocus,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
                              isPhone: false,
                              validatorType: ValidatorType.phone,
                              hintText: 'phone_number'.tr,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: MyDefaultButton(
                onPressed: () async {
                  if (formState.currentState!.validate()) {
                    formState.currentState!.save();
                    try {
                      String? phoneNum = await Constants.phoneParsing(
                        phone: phoneController.text,
                        countryCode: selcCountry.countryCode,
                      );

                      if (phoneNum != null) {
                        if (avatarFile != null) {
                          Future.delayed(Duration.zero, () {
                            if (!context.mounted) return;
                            Navigator.pushNamed(
                              context,
                              Routes.delivryRegisterSecondRoute,
                              arguments: DeliveryRegisterParams(
                                name: userNameController.text,
                                phone: phoneNum,
                                avatar: avatarFile,
                              ),
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
                        Future.delayed(Duration.zero, () {
                          if (!context.mounted) return;
                          Constants.showSnakToast(
                            type: 2,
                            context: context,
                            message: 'invalidPhoneText'.tr,
                          );
                        });
                      }
                    } on PlatformException catch (e) {
                      debugPrint(e.toString());

                      Future.delayed(Duration.zero, () {
                        if (!context.mounted) return;
                        Constants.showSnakToast(
                          type: 2,
                          context: context,
                          message: 'invalidPhoneText'.tr,
                        );
                      });
                    }
                  }
                },
                btnText: 'next',
              ),
            ),
            SizedBox(
              height: ScreenUtil().screenHeight * .03,
            )
          ],
        ),
      ),
    );
  }
}
