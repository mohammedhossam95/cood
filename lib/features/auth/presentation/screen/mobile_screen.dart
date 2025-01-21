import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/enums.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/loading_view.dart';
import '/core/widgets/my_default_button.dart';
import '/features/auth/domain/usecases/login_usecase.dart';
import '/features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '/features/auth/presentation/cubit/login/login_cubit.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/country_code_widget.dart';
import '../../../../core/widgets/exit_app_dialog.dart';
import '../../../../core/widgets/show_dialog.dart';
import '../../../../core/widgets/tags_text_form_field.dart';
import '../../../../injection_container.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});
  @override
  MobileScreenState createState() => MobileScreenState();
}

class MobileScreenState extends State<MobileScreen> {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode phoneFocus = FocusNode();

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
    return PopScope(
      onPopInvokedWithResult: (value, x) async {
        await showAppDialog(
              context: context,
              child: const ExitAppDialog(),
            ) ??
            false;
      },
      child: GestureDetector(
        onTap: () => unFocus(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 8,
            backgroundColor: colors.main,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: colors.upBackGround,
                ),
                Text(
                  '',
                  style: TextStyles.bold12(color: colors.upBackGround),
                ),
              ],
            ),
          ),
          backgroundColor: colors.upBackGround,
          body: BlocConsumer<AutoLoginCubit, AutoLoginState>(
            listener: (context, state) {
              // if (state is AutoLoginUserTypeState) {
              //   userType = state.userType;
              // }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Gaps.vGap40,
                        // SizedBox(
                        //   height: ScreenUtil().screenHeight * .46,
                        //   child: Stack(
                        //     children: [
                        //       Align(
                        //         alignment: Alignment.topCenter,
                        //         child: Image.asset(
                        //           ImgAssets.loginLogoImage,
                        //           width: 251.w,
                        //           height: 247.h,
                        //         ),
                        //       ),
                        //       Align(
                        //         alignment: Alignment.bottomCenter,
                        //         child: Image.asset(ImgAssets.imagesLogoAr),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'enterMobileNumber'.tr,
                                style: TextStyles.bold24(color: colors.main),
                                textAlign: TextAlign.right,
                              ),
                              Gaps.vGap10,
                              Text(
                                'confirmationMessage'.tr,
                                style: TextStyles.medium17(color: colors.main),
                                textAlign: TextAlign.right,
                              ),
                              Gaps.vGap40,
                              Row(
                                children: [
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
                                  SizedBox(width: 8.w),
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
                              Gaps.vGap40,
                              BlocConsumer<LoginCubit, LoginState>(
                                listener: (context, state) {
                                  if (state is LoginSuccessState) {
                                    log(state.resp.data?.phone ?? '');
                                    Navigator.pushNamed(
                                      context,
                                      Routes.otpAuthRoute,
                                      arguments: state.resp.data?.phone ?? '',
                                    );
                                  }
                                  if (state is LoginErrorState) {
                                    Constants.showSnakToast(
                                      context: context,
                                      type: 3,
                                      message: state.errorMessage,
                                    );
                                    log(userType!.name);
                                  }
                                },
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      (state is LoginLoadingState)
                                          ? const LoadingView()
                                          : MyDefaultButton(
                                              color: colors.secondary,
                                              borderColor: colors.secondary,
                                              onPressed: () =>
                                                  Navigator.pushNamed(context,
                                                      Routes.otpAuthRoute),
                                              // onLoginPressed(context),
                                              btnText: 'continue',
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
              );
            },
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
        );

        if (phoneNum != null) {
          login(phoneNum);
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

  login(String phone) {
    BlocProvider.of<LoginCubit>(context).fLoginPhone(
      params: LoginParams(
        phone: phone,
        userType: userType?.name,
      ),
    );
  }

  unFocus() {
    phoneFocus.unfocus();
  }
}
