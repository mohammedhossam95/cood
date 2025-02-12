import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/config/routes/app_routes.dart';
import 'package:cood/core/utils/values/img_manager.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../injection_container.dart';

class SuccessOtpScreen extends StatelessWidget {
  const SuccessOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Color(0xffF0F8FF) // Status bar color
          ),
    );
    return Scaffold(
      backgroundColor: colors.backGround,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageAssets.otpSuccess),
              Gaps.vGap35,
              Text(
                'otpSuccess'.tr,
                style: TextStyles.bold24(color: colors.main),
              ),
              Gaps.vGap10,
              Text(
                'otpVerified'.tr,
                style: TextStyles.bold24(color: colors.main),
                textAlign: TextAlign.center,
              ),
              Gaps.vGap35,
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 90.w),
                child: MyDefaultButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.successChangePassRoute);
                  },
                  borderColor: colors.main,
                  btnText: 'continueButton',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
