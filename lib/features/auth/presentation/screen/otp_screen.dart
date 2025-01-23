import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
// import '/features/auth/data/models/new_models/auth_model.dart';
// import '/features/auth/domain/usecases/new_usecases/pre_register_usecase.dart';
import '/features/auth/domain/usecases/new_usecases/verify_code_usecase.dart';
// import '/features/auth/presentation/cubit/new_cubit/pre_register/pre_register_cubit.dart';
import '/features/auth/presentation/cubit/new_cubit/verify_code/verify_code_cubit.dart';
import '/features/auth/presentation/widgets/pin_widget.dart';
import '/injection_container.dart';
// import '../../../../core/utils/constants.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/values/img_manager.dart';

class OtpAuthScreen extends StatefulWidget {
  // final AuthParam authParam;

  const OtpAuthScreen({
    super.key,
    // required this.authParam,
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
    // startTimer();
    // userType = BlocProvider.of<AutoLoginCubit>(context).userType;
    // userCycle = BlocProvider.of<AutoLoginCubit>(context).userCycle;
    // updateToken();
    preRegister();
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Color(0xff297AFF) // Status bar color
          ),
    );
    return Scaffold(
      backgroundColor: colors.upBackGround,
      body:
          // SafeArea(
          //   child: BlocConsumer<PreRegisterCubit, PreRegisterState>(
          //     listener: (context, preState) {
          //       if (preState is PreRegisterSuccessState) {
          //         setState(() {
          //           customerCode = preState.resp.details!.id.toString();
          //         });

          //         // }
          //       } else if (preState is PreRegisterErrorState) {
          //         preState.errorMessage == "رقم الجوال غير صحيح"
          //             ? Constants.showSnakToast(
          //                 context: context,
          //                 type: 2,
          //                 message: preState.errorMessage,
          //               )
          //             : Constants.showSnakToast(
          //                 context: context,
          //                 type: 3,
          //                 message: preState.errorMessage,
          //               );
          //         // Navigator.pop(context);
          //       }
          //     },
          //     builder: (context, state) {
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
                  Gaps.vGap42,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            color: colors.backGround,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gaps.vGap25,
                  Image.asset(ImageAssets.otpForgetPasswordScreenIcon),
                  Gaps.vGap15,
                  Text(
                    'enter_otp_number'.tr,
                    style: TextStyles.bold24(color: colors.upBackGround),
                  ),
                ],
              ),
            ),
            // (state is VerifyCodeLoadingState)
            //     ? SizedBox(
            //         height: ScreenUtil().screenHeight * .5,
            //         child: const Center(
            //             child: CircularProgressIndicator()),
            //       )
            //     :
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.vGap20,
                  Text(
                    'otp_verification_code'.tr,
                    style: TextStyles.bold32(color: colors.main),
                    textAlign: TextAlign.right,
                  ),

                  Gaps.vGap10,
                  Text(
                    'otp_verification_phrase'.tr,
                    style: TextStyles.medium17(color: colors.blackColor),
                    textAlign: TextAlign.right,
                  ),

                  Gaps.vGap40,

                  PinCodeWidget(
                    pinLength: 5,
                    
                    controller: codeController,
                    focus: codeFocus,
                    textSubmit: (t) {
                      BlocProvider.of<VerifyCodeCubit>(context).verifyCode(
                          params:
                              VerifyCodeParams(userCode: customerCode, otp: t),);
                    },
                  ),
                  Gaps.vGap35,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'not_have_otp'.tr,
                            style: TextStyles.bold15(),
                          ),
                          Gaps.vGap5,
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'resend_code_otp'.tr,
                              style: TextStyles.bold15(color: colors.main),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gaps.vGap25,
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 100.w),
                    child: MyDefaultButton(
                      color: colors.main,
                      borderColor: colors.main,
                      onPressed: () =>
                          // Navigator.pushNamed(context, Routes.otpAuthRoute),
                          Navigator.pushNamed(
                              context, Routes.confirmResetPasswordScreenRoute),
                      // onLoginPressed(context),
                      btnText: 'confirm_button',
                    ),
                  )

                  // Gaps.vGap47,
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                  //   child: DottedLine(
                  //     direction: Axis.horizontal,
                  //     alignment: WrapAlignment.center,
                  //     lineLength: double.infinity,
                  //     lineThickness: 1.0,
                  //     dashLength: 4.0,
                  //     dashColor: colors.unselected,
                  //     dashRadius: 0.0,
                  //     dashGapLength: 4.0,
                  //     dashGapColor: Colors.transparent,
                  //     dashGapRadius: 0.0,
                  //   ),
                  // ),
                  // Gaps.vGap25,
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                  //   child: Row(
                  //     mainAxisAlignment:
                  //         MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'resend_code'.tr,
                  //       ),
                  //       Text(
                  //         '00:$_start',
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            // if (state is VerifyCodeErrorState) ...[
            //   Center(
            //     child: Text(
            //       state.errorMessage,
            //       style: TextStyles.bold20(color: colors.errorColor),
            //     ),
            //   ),
          ],
        ),
      ),
    );
    //       },
    //     );
    //   },
    // ),
    //   ),
    // );
  }

  validator({required String isValid}) {
    if (isValid.isEmpty) {
      return 'Please Enter This Field';
    }
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

  preRegister() {
    // BlocProvider.of<PreRegisterCubit>(context).preRegister(
    //     params: PreRegisterParams(
    //         phoneNumber: widget.authParam.phoneNumber,
    //         countryCode: widget.authParam.countryCode));
  }
}
