import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/utils/values/assets.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
import '/injection_container.dart';

class GuestWidget extends StatelessWidget {
  const GuestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: colors.upBackGround,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100.r,
              backgroundColor: colors.main,
              child: Image.asset(ImgAssets.logo),
            ),
            Gaps.vGap25,
            Text(
              "welcome_to_app_title".tr,
              style: TextStyles.semiBold20(),
            ),
            Gaps.vGap4,
            Text(
              "welcome_to_app_message".tr,
              textAlign: TextAlign.center,
              style: TextStyles.regular18(),
            ),
            Gaps.vGap25,
            MyDefaultButton(
              width: 300.w,
              onPressed: () {
                Navigator.pushNamed(context, Routes.loginScreenRoute);
              },
              btnText: 'login',
              borderColor: colors.main,
            ),
          ],
        ),
      ),
    );
  }
}
