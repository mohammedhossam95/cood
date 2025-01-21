import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/utils/values/assets.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';

class SuccessChangePasswordScreen extends StatelessWidget {
  const SuccessChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(ImgAssets.imagesSuccessAlert),
              fit: BoxFit.fill,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Gaps.vGap145,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Column(
                    children: [
                      Text(
                        'success_change_password'.tr,
                        style: TextStyles.bold19(),
                        textAlign: TextAlign.center,
                      ),
                      Gaps.vGap12,
                      Text(
                        'relogIn'.tr,
                        style: TextStyles.regular13()
                            .copyWith(fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Image.asset(ImgAssets.imagesSuccessAlert),
                MyDefaultButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.loginScreenRoute);
                  },
                  btnText: 'login',
                ),
              ],
            )),
      ),
    );
  }
}
