import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/values/img_manager.dart';
import '../../../../core/widgets/gaps.dart';
import '../../../../injection_container.dart';

class SuccessChangePasswordScreen extends StatelessWidget {
  const SuccessChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageAssets.forgetPasswordCheckDoneScreenIcon),
            Gaps.vGap10,
            Text(
              'saved_new_password'.tr,
              textAlign: TextAlign.center,
              style: TextStyles.bold24(color: colors.main),
            ),
            // MyDefaultButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, Routes.loginScreenRoute);
            //   },
            //   btnText: 'login',
            // ),
          ],
        ),
      ),
    );
  }
}
