import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/enums.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
import '/features/auth/domain/usecases/new_usecases/new_login_usecase.dart';
import '/features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '/features/auth/presentation/cubit/new_cubit/new_login/new_login_cubit.dart';
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
              child: Column(
                children: [
                  Gaps.vGap100,
                  Gaps.vGap100,
                  Image.asset(
                    ImgAssets.jzlLogo,
                  ),
                  Gaps.vGap100,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'login'.tr,
                          style: TextStyles.bold24(
                            color: colors.main,
                          ),
                        ),
                        Gaps.vGap10,
                        // CountryCodeWidget(
                        //   country: selcCountry,
                        //   updateValue: (Country value) {
                        //     setState(() {
                        //       selcCountry = value;
                        //     });
                        //   },
                        // ),
                        // SizedBox(width: 8.w),
                        AppTextFormField(
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
                        Gaps.vGap8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: isCheck,
                                  activeColor: colors.main,
                                  onChanged: (value) {
                                    setState(() {
                                      isCheck = value ?? false;
                                    });
                                  },
                                ),
                                Text(
                                  'rememberMe'.tr,
                                  style: TextStyles.semiBold14(),
                                )
                              ],
                            ),
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
                        // BlocConsumer<NewLoginCubit, NewLoginState>(
                        //   listener: (context, state) {
                        //     if (state is NewLoginSuccessState) {
                        //       log(state.resp.details?.token ?? '');

                        //       BlocProvider.of<AutoLoginCubit>(context)
                        //           .saveUserCycle(type: UserCycle.auth);
                        //       BlocProvider.of<AutoLoginCubit>(context)
                        //           .saveUserType(type: UserType.approved);
                        //       Navigator.pushNamedAndRemoveUntil(
                        //         context,
                        //         Routes.mainPageRoute,
                        //         (Route route) => false,
                        //       );
                        //     }
                        //     if (state is NewLoginErrorState) {
                        //       if (state.errorMessage ==
                        //               "هذا العميل غير موجود" ||
                        //           state.errorMessage ==
                        //               "This user is not found") {
                        //         CustomAlert().showAlertDialog(
                        //           context: context,
                        //           onpress: () {
                        //             Navigator.pushNamed(
                        //               context,
                        //               Routes.otpAuthRoute,
                        //               arguments: AuthParam(phoneController.text,
                        //                   selcCountry.phoneCode, ""),
                        //             );
                        //           },
                        //           title: state.errorMessage,
                        //           subTitle: "create_account".tr,
                        //           btnTitle: 'confirm',
                        //           isDismissible: true,
                        //           color: colors.secondary,
                        //         );
                        //       } else {
                        //         Constants.showSnakToast(
                        //           context: context,
                        //           type: 3,
                        //           message: state.errorMessage,
                        //         );
                        //       }

                        //       log(userType!.name);
                        //     }
                        //   },
                        //   builder: (context, state) {
                        //     return Column(
                        //       children: [
                        //         (state is NewLoginLoadingState)
                        //             ? LoadingView(
                        //                 bgColor: colors.secondary,
                        //               )
                        //             :
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.w),
                          child: MyDefaultButton(
                            color: colors.main,
                            borderColor: colors.main,
                            onPressed: () =>
                                // Navigator.pushNamed(context,
                                //     Routes.otpAuthRoute),
                                onLoginPressed(context),
                            btnText: 'login',
                          ),
                        ),
                        Gaps.vGap10,
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, Routes.newUserRegisterRoute);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'notHaveAccount'.tr,
                                style: TextStyles.bold17(),
                              ),
                              Gaps.hGap6,
                              Text(
                                'createNewAccount'.tr,
                                style: TextStyles.bold17(color: colors.main),
                              ),
                            ],
                          ),
                        ),
                        // if (state is LoginErrorState) ...[]
                        //   ],
                        // ),
                        // },
                        // ),
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
      Navigator.pushReplacementNamed(context, Routes.mainPageRoute);
      // try {
      //   login(phoneController.text, passwordController.text);
      // } on PlatformException catch (e) {
      //   debugPrint(e.toString());
      //   unFocus();
      //   Future.delayed(Duration.zero, () {
      //     if (!context.mounted) return;
      //     Constants.showSnakToast(
      //       type: 2,
      //       context: context,
      //       message: 'invalidPhoneText'.tr,
      //     );
      //   });
      // }
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
