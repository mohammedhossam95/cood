import 'dart:developer';

import 'package:cood/core/params/auth_params.dart';
import 'package:cood/core/utils/constants.dart';
import 'package:cood/core/widgets/custom_alert.dart';
import 'package:cood/core/widgets/loading_view.dart';
import 'package:cood/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:cood/features/auth/presentation/widgets/country_code_widget.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/enums.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
import '/features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/utils/values/assets.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/tags_text_form_field.dart';
import '../../../../injection_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  String firebaseToken = '';

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

  UserType? userType;
  @override
  void initState() {
    BlocProvider.of<AutoLoginCubit>(context).getUserType();
    userType = BlocProvider.of<AutoLoginCubit>(context).userType;
    // readLocal();
    super.initState();
  }

  void readLocal() {
    FirebaseMessaging.instance.getToken().then((token) {
      debugPrint('token $token');
      firebaseToken = token!;
    }).catchError((onError) {
      Constants.showSnakToast(
        // ignore: use_build_context_synchronously
        context: context,
        type: 3,
        message: onError.toString(),
      );
    });
  }

  bool isSecured = true;
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(),
      child: Scaffold(
        backgroundColor: colors.backGround,
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gaps.vGap100,
                    Image.asset(ImgAssets.logo),
                    Gaps.vGap50,
                    Text(
                      'login'.tr,
                      style: TextStyles.bold24(
                        color: colors.main,
                      ),
                    ),
                    Gaps.vGap10,
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
                            backgroundColor: colors.upBackGround,
                            controller: phoneController,
                            focusNode: phoneFocus,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            isPhone: false,
                            validatorType: ValidatorType.phone,
                            hintText: 'phone_number'.tr,
                            borderColor: colors.main,
                          ),
                        ),
                      ],
                    ),
                    Gaps.vGap25,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.forgetPasswordScreenRoute,
                            );
                          },
                          child: Text(
                            'forgetPassword'.tr,
                            style: TextStyles.semiBold14(),
                          ),
                        ),
                      ],
                    ),
                    Gaps.vGap78,
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccessState) {
                          log(state.resp.result?.token ?? '');

                          BlocProvider.of<AutoLoginCubit>(context)
                              .saveUserCycle(type: UserCycle.auth);
                          BlocProvider.of<AutoLoginCubit>(context)
                              .saveUserType(type: UserType.approved);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.mainPageRoute,
                            (Route route) => false,
                          );
                        }
                        if (state is LoginErrorState) {
                          if (state.errorMessage == "هذا العميل غير موجود" ||
                              state.errorMessage == "This user is not found") {
                            CustomAlert().showAlertDialog(
                              context: context,
                              onpress: () {
                                // Navigator.pushNamed(
                                //   context,
                                //   Routes.otpAuthRoute,
                                //   arguments: AuthParam(phoneController.text,
                                //       selcCountry.phoneCode, ""),
                                // );
                              },
                              title: state.errorMessage,
                              subTitle: "create_account".tr,
                              btnTitle: 'confirm',
                              isDismissible: true,
                              color: colors.secondary,
                            );
                          } else {
                            Constants.showSnakToast(
                              context: context,
                              type: 3,
                              message: state.errorMessage,
                            );
                          }

                          log(userType!.name);
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50.w),
                              child: (state is LoginLoadingState)
                                  ? LoadingView(
                                      bgColor: colors.main,
                                    )
                                  : MyDefaultButton(
                                      color: colors.main,
                                      borderColor: colors.main,
                                      onPressed: () => onLoginPressed(context),
                                      btnText: 'login',
                                    ),
                            ),
                            if (state is LoginErrorState) ...[
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
                    Gaps.vGap10,
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        Routes.registerRoute,
                        arguments: AuthParams(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'notHaveAccount'.tr,
                            style: TextStyles.semiBold14(),
                          ),
                          Gaps.hGap6,
                          Text(
                            'createNewAccount'.tr,
                            style: TextStyles.semiBold14(color: colors.main),
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
      ),
    );
  }

  onLoginPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        String? phoneNum = await Constants.phoneParsing(
          phone: phoneController.text,
          countryCode: selcCountry.countryCode,
          withCode: false,
        );

        if (phoneNum != null) {
          login(phoneNum, passwordController.text);
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

  login(String phone, String password) {
    BlocProvider.of<LoginCubit>(context).fLoginPhone(
      params: AuthParams(
        phone: phone,
        password: passwordController.text,
        token: firebaseToken,
      ),
    );
  }

  unFocus() {
    phoneFocus.unfocus();
    passwordFocus.unfocus();
  }
}
