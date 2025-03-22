import 'dart:developer';

import 'package:cood/config/routes/app_routes.dart';
import 'package:cood/core/params/auth_params.dart';
import 'package:cood/core/utils/constants.dart';
import 'package:cood/core/widgets/custom_alert.dart';
import 'package:cood/core/widgets/loading_view.dart';
import 'package:cood/features/auth/presentation/cubit/verify_otp/verify_otp_cubit.dart';
import 'package:cood/features/auth/presentation/widgets/custom_back_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
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

class _OtpAuthScreenState extends State<OtpAuthScreen>
    with TickerProviderStateMixin {
  final TextEditingController codeController = TextEditingController(text: "");
  final FocusNode codeFocus = FocusNode();
  late UserType userType;
  late UserCycle userCycle;
  String firebaseToken = '';
  String? deviceType;
  String? customerCode;

  final Duration timeOut = const Duration(seconds: 60);
  AnimationController? timecontroller;

  @override
  void initState() {
    timecontroller = AnimationController(vsync: this, duration: timeOut);
    _initTimer();

    super.initState();
  }

  _initTimer() {
    log("${timecontroller!.value} value");
    timecontroller!.reverse(
      from: timecontroller!.value == 0.0 ? 1.0 : timecontroller!.value,
    );
  }

  @override
  void dispose() {
    timecontroller!.dispose();
    codeController.dispose();
    super.dispose();
  }

  updateToken() async {}
  String get timerString {
    Duration duration = timecontroller!.duration! * timecontroller!.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
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
      body: BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
        listener: (context, state) {
          if (state is VerifyOtpSuccess) {
            CustomAlert().showAlertDialog(
              context: context,
              title: state.resp.status ?? '',
              subTitle: state.resp.message ?? '',
              btnTitle: 'login',
              onpress: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.loginScreenRoute,
                  (route) => false,
                );
              },
            );
          } else if (state is VerifyOtpError) {
            Constants.showSnakToast(
              context: context,
              type: 3,
              message: state.errorMessage,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 28.w),
                  color: colors.main,
                  child: Column(
                    children: [
                      Gaps.vGap16,
                      Image.asset(ImageAssets.otpForgetPasswordScreenIcon),
                      Gaps.vGap16,
                      Text(
                        'enterOtpNumber'.tr,
                        style: TextStyles.bold20(color: colors.upBackGround),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: ScreenUtil().screenHeight * 0.6,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  color: colors.backGround,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gaps.vGap20,
                      Text(
                        'otpVerificationPhrase'.tr,
                        style: TextStyles.medium17(color: colors.blackColor),
                        textAlign: TextAlign.right,
                      ),
                      Gaps.vGap40,
                      PinCodeWidget(
                        pinLength: 4,
                        controller: codeController,
                        focus: codeFocus,
                        textSubmit: (code) {
                          BlocProvider.of<VerifyOtpCubit>(context).fVerifyOtp(
                            params: AuthParams(
                              userId: widget.authParams.userId ?? 0,
                              otp: code,
                            ),
                          );
                        },
                      ),
                      Gaps.vGap35,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'notHaveOtp'.tr,
                            style: TextStyles.medium14(),
                          ),
                          Gaps.hGap10,
                          AnimatedBuilder(
                            animation: timecontroller!,
                            builder: (BuildContext context, Widget? child) {
                              return timecontroller!.value == 0.0
                                  ? InkWell(
                                      // onTap: () => resendVerificationCode(),
                                      child: Text(
                                      'resend_code'.tr,
                                      style: TextStyles.medium14(
                                          color: colors.main),
                                    ))
                                  : Text(
                                      "${'resend'.tr} ($timerString)",
                                      style: TextStyles.medium14(),
                                    );
                            },
                          ),
                        ],
                      ),
                      Gaps.vGap40,
                      (state is VerifyOtpLoading)
                          ? LoadingView()
                          : MyDefaultButton(
                              color: colors.main,
                              btnText: 'confirm_button',
                              onPressed: () {
                                BlocProvider.of<VerifyOtpCubit>(context)
                                    .fVerifyOtp(
                                  params: AuthParams(
                                    userId: widget.authParams.userId ?? 0,
                                    otp: codeController.text,
                                  ),
                                );
                              },
                            ),
                      if (state is VerifyOtpError) ...[
                        Gaps.vGap10,
                        Text(
                          state.errorMessage,
                          style: TextStyles.medium14(color: Colors.red),
                        ),
                      ],
                      Gaps.vGap30,
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
