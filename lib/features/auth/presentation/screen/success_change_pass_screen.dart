import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/values/img_manager.dart';
import '../../../../core/widgets/gaps.dart';
import '../../../../injection_container.dart';

class SuccessChangePasswordScreen extends StatefulWidget {
  const SuccessChangePasswordScreen({super.key});

  @override
  State<SuccessChangePasswordScreen> createState() =>
      _SuccessChangePasswordScreenState();
}

class _SuccessChangePasswordScreenState
    extends State<SuccessChangePasswordScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 2),
      () {
         Navigator.pushNamed(context, Routes.mainPageRoute);
      },
    );
    super.initState();
  }

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
              'savedNewPassword'.tr,
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
