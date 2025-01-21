import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
import '/features/auth/data/models/new_models/auth_model.dart';
import '/features/auth/domain/usecases/new_usecases/pre_register_usecase.dart';
import '/features/auth/domain/usecases/new_usecases/verify_code_usecase.dart';
import '/features/auth/presentation/cubit/new_cubit/pre_register/pre_register_cubit.dart';
import '/features/auth/presentation/cubit/new_cubit/verify_code/verify_code_cubit.dart';
import '/features/auth/presentation/widgets/pin_widget.dart';
import '/injection_container.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/enums.dart';

class OtpAuthScreen extends StatefulWidget {
  final AuthParam authParam;

  const OtpAuthScreen({super.key, required this.authParam});

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
  late String? customerCode;

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

    return Scaffold(
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
            InkWell(
              onTap: () {
                // Navigator.pushNamed(context, Routes.newUserRegisterRoute);
              },
              child: Text(
                '',
                style: TextStyles.bold12(color: colors.upBackGround),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: colors.upBackGround,
      body: SafeArea(
        child: BlocConsumer<PreRegisterCubit, PreRegisterState>(
          listener: (context, preState) {
            if (preState is PreRegisterSuccessState) {
              setState(() {
                customerCode = preState.resp.details!.id.toString();
              });

              // }
            } else if (preState is PreRegisterErrorState) {
              preState.errorMessage == "رقم الجوال غير صحيح"
                  ? Constants.showSnakToast(
                      context: context,
                      type: 2,
                      message: preState.errorMessage,
                    )
                  : Constants.showSnakToast(
                      context: context,
                      type: 3,
                      message: preState.errorMessage,
                    );
              // Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
              listener: (context, state) {
                if (state is VerifyCodeSuccessState) {
                  Navigator.pushNamed(
                    context,
                    Routes.newUserRegisterRoute,
                    arguments: AuthParam(
                      widget.authParam.phoneNumber,
                      widget.authParam.countryCode,
                      customerCode!,
                    ),
                  );

                  // }
                } else if (state is VerifyCodeErrorState) {
                  state.errorMessage == "رقم الجوال غير صحيح"
                      ? Constants.showSnakToast(
                          context: context,
                          type: 2,
                          message: state.errorMessage,
                        )
                      : Constants.showSnakToast(
                          context: context,
                          type: 3,
                          message: state.errorMessage,
                        );
                  // Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      (state is VerifyCodeLoadingState)
                          ? SizedBox(
                              height: ScreenUtil().screenHeight * .5,
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image.asset(
                                  //   ImgAssets.imagesSuccessAlert,
                                  // ),
                                  Gaps.vGap40,
                                  Text(
                                    'enterConfirmationCode'.tr,
                                    style:
                                        TextStyles.bold24(color: colors.main),
                                    textAlign: TextAlign.right,
                                  ),

                                  Gaps.vGap10,
                                  Text(
                                    'codeSent'.tr +
                                        widget.authParam.phoneNumber,
                                    style:
                                        TextStyles.medium17(color: colors.main),
                                    textAlign: TextAlign.right,
                                  ),

                                  Gaps.vGap40,

                                  Gaps.vGap30,

                                  PinCodeWidget(
                                    pinLength: 5,
                                    controller: codeController,
                                    focus: codeFocus,
                                    textSubmit: (t) {
                                      BlocProvider.of<VerifyCodeCubit>(context)
                                          .verifyCode(
                                              params: VerifyCodeParams(
                                                  userCode: customerCode,
                                                  otp: t));
                                    },
                                  ),
                                  Gaps.vGap47,
                                  MyDefaultButton(
                                    color: colors.secondary,
                                    borderColor: colors.secondary,
                                    onPressed: () =>
                                        // Navigator.pushNamed(context, Routes.otpAuthRoute),
                                        Navigator.pushNamed(context,
                                            Routes.newUserRegisterRoute),
                                    // onLoginPressed(context),
                                    btnText: 'resend_code',
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
                      if (state is VerifyCodeErrorState) ...[
                        Center(
                          child: Text(
                            state.errorMessage,
                            style: TextStyles.bold20(color: colors.errorColor),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
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
    BlocProvider.of<PreRegisterCubit>(context).preRegister(
        params: PreRegisterParams(
            phoneNumber: widget.authParam.phoneNumber,
            countryCode: widget.authParam.countryCode));
  }
}
