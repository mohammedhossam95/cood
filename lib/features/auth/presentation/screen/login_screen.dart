import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/enums.dart';
import '/core/widgets/custom_alert.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/loading_view.dart';
import '/core/widgets/my_default_button.dart';
import '/features/auth/data/models/new_models/auth_model.dart';
import '/features/auth/domain/usecases/new_usecases/new_login_usecase.dart';
import '/features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '/features/auth/presentation/cubit/new_cubit/new_login/new_login_cubit.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/country_code_widget.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 8,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: colors.main,
          title: Row(
            children: [
              const Spacer(),
              Text(
                'register'.tr,
                style: TextStyles.bold12(color: colors.upBackGround),
              ),
            ],
          ),
        ),
        backgroundColor: colors.upBackGround,
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gaps.vGap40,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'loginWelcome'.tr,
                          style: TextStyles.bold24(color: colors.main),
                          textAlign: TextAlign.right,
                        ),
                        Gaps.vGap10,
                        Text(
                          'loginWelcomeDesc'.tr,
                          style: TextStyles.medium17(color: colors.main),
                          textAlign: TextAlign.right,
                        ),
                        Gaps.vGap40,
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
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                isPhone: false,
                                validatorType: ValidatorType.phone,
                                hintText: 'phone_number'.tr,
                              ),
                            ),
                          ],
                        ),
                        Gaps.vGap25,
                        AppTextFormField(
                          controller: passwordController,
                          focusNode: passwordFocus,
                          hintText: 'password'.tr,
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          validatorType: ValidatorType.password,
                        ),
                        Gaps.vGap40,
                        BlocConsumer<NewLoginCubit, NewLoginState>(
                          listener: (context, state) {
                            if (state is NewLoginSuccessState) {
                              log(state.resp.details?.token ?? '');

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
                            if (state is NewLoginErrorState) {
                              if (state.errorMessage ==
                                      "هذا العميل غير موجود" ||
                                  state.errorMessage ==
                                      "This user is not found") {
                                CustomAlert().showAlertDialog(
                                  context: context,
                                  onpress: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.otpAuthRoute,
                                      arguments: AuthParam(phoneController.text,
                                          selcCountry.phoneCode, ""),
                                    );
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
                              children: [
                                (state is NewLoginLoadingState)
                                    ? LoadingView(
                                        bgColor: colors.secondary,
                                      )
                                    : MyDefaultButton(
                                        color: colors.secondary,
                                        borderColor: colors.secondary,
                                        onPressed: () =>
                                            // Navigator.pushNamed(context,
                                            //     Routes.otpAuthRoute),
                                            onLoginPressed(context),
                                        btnText: 'login',
                                      ),
                                // if (state is LoginErrorState) ...[]
                              ],
                            );
                          },
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

  onLoginPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        login(phoneController.text, passwordController.text);
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
    BlocProvider.of<NewLoginCubit>(context).login(
      params: NewLoginParams(
          phoneNumber: phoneController.text,
          password: passwordController.text,
          fcmToken: ""),
    );
  }

  unFocus() {
    phoneFocus.unfocus();
    passwordFocus.unfocus();
  }
}
