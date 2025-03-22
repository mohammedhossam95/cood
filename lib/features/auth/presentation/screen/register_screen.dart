import 'dart:io';

import 'package:cood/config/routes/app_routes.dart';
import 'package:cood/core/params/auth_params.dart';
import 'package:cood/core/utils/constants.dart';
import 'package:cood/core/widgets/loading_view.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/features/auth/domain/entities/user_register_response.dart';
import 'package:cood/features/auth/presentation/cubit/user_register_cubit/user_register_cubit.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/values/assets.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/tags_text_form_field.dart';
import '/injection_container.dart';
import '../../../../core/utils/validator.dart';
import '../widgets/country_code_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode userNameFocus = FocusNode();
  final FocusNode configPasswordFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();

  bool isSecured = true;
  bool isSecured1 = true;
  bool checkTerms = false;

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
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gaps.vGap100,
                  Image.asset(ImgAssets.logo),
                  Gaps.vGap50,
                  Text(
                    'welcomphrase'.tr,
                    style: TextStyles.bold24(
                      color: colors.main,
                    ),
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
                    validatorType: ValidatorType.standard,
                    borderColor: colors.main,
                  ),
                  Gaps.vGap16,
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
                          hintText: 'phone'.tr,
                          textInputAction: TextInputAction.next,
                          validatorType: ValidatorType.phone,
                          borderColor: colors.main,
                        ),
                      ),
                    ],
                  ),
                  Gaps.vGap16,
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
                  Gaps.vGap16,
                  AppTextFormField(
                    backgroundColor: colors.upBackGround,
                    controller: confirmPasswordController,
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
                  Gaps.vGap16,
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context,
                                  Routes.tearmsAndCondationsAuthScreenRoute);
                            },
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
                      Switch.adaptive(
                        value: checkTerms,
                        activeColor: colors.main,
                        onChanged: (v) {
                          setState(() {
                            checkTerms = v;
                          });
                        },
                      ),
                    ],
                  ),
                  Gaps.vGap25,
                  BlocConsumer<UserRegisterCubit, UserRegisterState>(
                    listener: (context, state) {
                      if (state is UserRegisterSuccess) {
                        RegResult result = state.resp.data as RegResult;
                        Navigator.pushNamed(
                          context,
                          Routes.otpAuthRoute,
                          arguments: AuthParams(
                            phone: state.params.phone ?? '',
                            userId: result.userId ?? 0,
                          ),
                        );
                      }
                      if (state is UserRegisterFailure) {
                        Constants.showSnakToast(
                          context: context,
                          type: 3,
                          message: state.errorMessage,
                        );
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          (state is UserRegisterLoading)
                              ? LoadingView(bgColor: colors.main)
                              : MyDefaultButton(
                                  color: colors.main,
                                  borderColor: colors.main,
                                  onPressed: () => onRegisterPressed(context),
                                  btnText: 'createAccount',
                                ),
                          if (state is UserRegisterFailure) ...[
                            Gaps.vGap10,
                            Text(
                              state.errorMessage,
                              style: TextStyles.regular14(
                                  color: colors.errorColor),
                            ),
                          ]
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onRegisterPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        String? phoneNum = await Constants.phoneParsing(
          phone: phoneController.text,
          countryCode: selcCountry.countryCode,
          withCode: false,
        );

        if (phoneNum != null) {
          register(phoneNum);
        } else {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => Constants.showSnakToast(
              type: 2,
              context: context,
              message: 'invalidPhoneText'.tr,
            ),
          );
        }
      } on PlatformException catch (e) {
        debugPrint(e.toString());
        unFocus();
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
  }

  register(String phone) {
    if (checkTerms == true) {
      BlocProvider.of<UserRegisterCubit>(context).fRegister(
        params: AuthParams(
          name: userNameController.text,
          phone: phone,
          password: passwordController.text,
          passwordConfirm: passwordController.text,
        ),
      );
    } else {
      Constants.showSnakToast(
        context: context,
        type: 3,
        message: "accept_terms_agreement".tr,
      );
    }
  }

  unFocus() {
    userNameFocus.unfocus();
    configPasswordFocus.unfocus();
    passwordFocus.unfocus();
    // phoneFocus.unfocus();
  }
}
