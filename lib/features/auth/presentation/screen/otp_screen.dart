import 'dart:async';

import 'package:cood/core/params/auth_params.dart';
import 'package:cood/features/auth/presentation/widgets/custom_back_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
// import '/features/auth/presentation/cubit/new_cubit/pre_register/pre_register_cubit.dart';
import '/features/auth/presentation/widgets/pin_widget.dart';
import '/injection_container.dart';
// import '../../../../core/utils/constants.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/values/img_manager.dart';

class OtpAuthScreen extends StatefulWidget {
  final AuthParams authParams;

  const OtpAuthScreen({
    super.key,
    required this.authParams,
  });

  @override
  State<OtpAuthScreen> createState() => _OtpAuthScreenState();
}

class _OtpAuthScreenState extends State<OtpAuthScreen> {
  final TextEditingController codeController = TextEditingController(text: "");
  final FocusNode codeFocus = FocusNode();
  late UserType userType;
  late Timer _timer;
  int _start = 60;
  late UserCycle userCycle;
  String firebaseToken = '';
  String? deviceType;
  String? customerCode;

  @override
  @override
  void initState() {
    startTimer();
    // userType = BlocProvider.of<AutoLoginCubit>(context).userType;
    // userCycle = BlocProvider.of<AutoLoginCubit>(context).userCycle;
    // updateToken();

    super.initState();
  }

  updateToken() async {}

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var phoneNumber = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: colors.main,
      appBar: AppBar(
        backgroundColor: colors.main,
        elevation: 0,
        leading: CustomBack(),
      ),
      body:

          //       return BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
          //         listener: (context, state) {
          //           if (state is VerifyCodeSuccessState) {
          //             Navigator.pushNamed(
          //               context,
          //               Routes.newUserRegisterRoute,
          //               // arguments: AuthParam(
          //               //   widget.authParam.phoneNumber,
          //               //   widget.authParam.countryCode,
          //               //   customerCode!,
          //               // ),
          //             );

          //             // }
          //           } else if (state is VerifyCodeErrorState) {
          //             state.errorMessage == "رقم الجوال غير صحيح"
          //                 ? Constants.showSnakToast(
          //                     context: context,
          //                     type: 2,
          //                     message: state.errorMessage,
          //                   )
          //                 : Constants.showSnakToast(
          //                     context: context,
          //                     type: 3,
          //                     message: state.errorMessage,
          //                   );
          //             // Navigator.pop(context);
          //           }
          //         },
          //         builder: (context, state) {
          //           return SingleChildScrollView(
          SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 0.3.sh,
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 28.w),
              color: colors.main,
              child: Column(
                children: [
                  Gaps.vGap25,
                  Image.asset(ImageAssets.otpForgetPasswordScreenIcon),
                  Gaps.vGap15,
                  Text(
                    'enterOtpNumber'.tr,
                    style: TextStyles.bold20(color: colors.upBackGround),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              color: colors.backGround,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.vGap20,
                  Text(
                    'otpVerificationCode'.tr,
                    style: TextStyles.bold24(color: colors.main),
                    textAlign: TextAlign.right,
                  ),
                  Gaps.vGap10,
                  Text(
                    'otpVerificationPhrase'.tr,
                    style: TextStyles.medium17(color: colors.blackColor),
                    textAlign: TextAlign.right,
                  ),
                  Gaps.vGap40,
                  PinCodeWidget(
                    pinLength: 5,
                    controller: codeController,
                    focus: codeFocus,
                    textSubmit: (t) {
                      // BlocProvider.of(context).verifyCode(
                      //   params:
                      //       VerifyCodeParams(userCode: customerCode, otp: t),
                      // );
                    },
                  ),
                  Gaps.vGap35,
                  /*
                  Gaps.vGap30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.text('codeNotSent'),
                        style: theme.bodyMedium!.copyWith(
                          fontSize: 14.sp,
                          color: colors(context).body,
                        ),
                      ),
                      Gaps.hGap10,
                      AnimatedBuilder(
                        animation: timeController!,
                        builder: (BuildContext context, Widget? child) {
                          return timeController!.value == 0.0
                              ? InkWell(
                                  onTap: () => resendVerificationCode(),
                                  child: Text(
                                    locale.text('resend_code'),
                                    style: theme.bodyMedium!.copyWith(
                                        fontSize: 14.sp,
                                        color: colors(context).main),
                                  ))
                              : Text(
                                  "${'resend'.tr} ($timerString)",
                                  style: theme.bodyMedium!.copyWith(
                                      fontSize: 14.sp,
                                      color: colors(context).body),
                                );
                        },
                      ),
                    ],
                  ),
                  Gaps.vGap30,
                  */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'notHaveOtp'.tr,
                            style: TextStyles.bold15(),
                          ),
                          Gaps.vGap5,
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'resendCodeOtp'.tr,
                              style: TextStyles.bold15(color: colors.main),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gaps.vGap25,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100.w),
                    child: MyDefaultButton(
                      color: colors.main,
                      borderColor: colors.main,
                      onPressed: () => Navigator.pushNamed(
                          context, Routes.successOtpScreenRoute),
                      //  Navigator.pushNamed(context, Routes.failedOtpScreenRoute),

                      // Navigator.pushNamed(
                      //     context, Routes.confirmResetPasswordScreenRoute),
                      // onLoginPressed(context),
                      btnText: 'confirm_button',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
