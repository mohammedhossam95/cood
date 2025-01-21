import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/routes/app_routes.dart';
import '/core/utils/extension.dart';
import '../../../../core/utils/values/gif_manager.dart';
import '../../../../core/utils/values/strings.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../../../core/widgets/exit_app_dialog.dart';
import '../../../../core/widgets/show_dialog.dart';
import '../../../../injection_container.dart';
import '../cubit/reset_password/reset_password_cubit.dart';
import '../cubit/verify_reset_password/verify_reset_password_cubit.dart';
import '../widgets/pin_widget.dart';

class VerificationResetPasswordScreen extends StatefulWidget {
  const VerificationResetPasswordScreen({
    super.key,
  });

  @override
  VerificationResetPasswordScreenState createState() =>
      VerificationResetPasswordScreenState();
}

class VerificationResetPasswordScreenState
    extends State<VerificationResetPasswordScreen>
    with TickerProviderStateMixin {
  final TextEditingController controller = TextEditingController();
  final FocusNode codeFocus = FocusNode();
  int pinLength = 4;
  bool focus = true;
  final Duration timeOut = const Duration(seconds: 60);
  AnimationController? timeController;

  @override
  void initState() {
    super.initState();
    timeController = AnimationController(vsync: this, duration: timeOut);
    _initTimer();
  }

  @override
  void dispose() {
    timeController!.dispose();
    controller.dispose();
    super.dispose();
  }

  _initTimer() {
    timeController!.reverse(
        from: timeController!.value == 0.0 ? 1.0 : timeController!.value);
  }

  String get timerString {
    Duration duration = timeController!.duration! * timeController!.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (value, result) async {
        await showAppDialog(
              context: context,
              child: const ExitAppDialog(),
            ) ??
            false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colors.upBackGround,
        appBar: AppBar(
          backgroundColor: colors.upBackGround,
        ),
        body: BlocConsumer<VerifyResetPasswordCubit, VerifyResetPasswordState>(
          listener: (BuildContext context, VerifyResetPasswordState state) {
            if (state is VerifyResetPasswordSuccessState) {
              goNext();
            } else if (state is VerifyResetPasswordErrorState) {
              showAppSnackBar(
                  context: context,
                  message: state.message,
                  type: ToastType.error);
            }
          },
          builder: (BuildContext context, VerifyResetPasswordState state) {
            return GestureDetector(
              onTap: () => unFocus(),
              child: Container(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.0,
                          color: colors.borderColor,
                        ),
                      ),
                      child: Image.asset(
                        GifAssets.otp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      Strings.resetPassword,
                      style: TextStyles.medium20(color: colors.highlight),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      Strings.enterConfirmationCodeSentToEmail,
                      style: TextStyles.regular16(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      context.read<ResetPasswordCubit>().email ?? '',
                      style: TextStyles.medium16(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    PinCodeWidget(
                      pinLength: pinLength,
                      controller: controller,
                      focus: codeFocus,
                      textSubmit: (String text) => submitVerificationCode(text),
                    ),
                    SizedBox(height: 16.h),
                    (state is VerifyResetPasswordLoadingState)
                        ? const CircularProgressIndicator().appLoading
                        : const SizedBox(),
                    (state is VerifyResetPasswordErrorState)
                        ? const SizedBox(height: 8.0)
                        : const SizedBox(),
                    (state is VerifyResetPasswordErrorState)
                        ? SizedBox(
                            width: double.infinity,
                            child: Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: TextStyles.regular16(color: Colors.red),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void submitVerificationCode(String text) async {
    if (text.isNotEmpty && text.length == pinLength) {
      // if (widget.isVerifyEditedMobile) {
      //   context
      //       .read<VerifyEditedMobileCubit>()
      //       .fVerifyEditedMobile(mobile: widget.phone, code: text);
      // } else {
      context.read<VerifyResetPasswordCubit>().fVerifyResetPassword(
            email: context.read<ResetPasswordCubit>().email ?? '',
            code: text,
          );
    }
  }

  void goNext() {
    Navigator.pushReplacementNamed(
      context,
      Routes.confirmResetPasswordScreenRoute,
    );
  }

  unFocus() {
    codeFocus.unfocus();
  }
}
