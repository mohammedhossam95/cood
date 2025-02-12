import 'package:cood/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/values/img_manager.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/gaps.dart';
import '../../../../core/widgets/my_default_button.dart';
import '../../../../injection_container.dart';

class FailedOtpScreen extends StatelessWidget {
  const FailedOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      backgroundColor: colors.backGround,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImageAssets.otpFailed),
                Gaps.vGap35,
                Text(
                  'otpFailed'.tr,
                  style: TextStyles.bold24(color: colors.main),
                ),
                Gaps.vGap10,
                Text(
                  'otpincorrect'.tr,
                  style: TextStyles.bold24(color: colors.main),
                  textAlign: TextAlign.center,
                ),
                Gaps.vGap35,
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 90.w),
                  child: MyDefaultButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    borderColor: colors.main,
                    btnText: 'trtAgain',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}