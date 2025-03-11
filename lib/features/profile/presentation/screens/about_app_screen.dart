import 'package:cood/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/values/text_styles.dart';
import '/injection_container.dart';
import '../../../../core/utils/values/assets.dart';
import '../../../../core/widgets/gaps.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: colors.backGround,
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 25.w,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'about_app'.tr,
                              style: TextStyles.bold32(color: colors.main),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40.h,
                          width: 40.w,
                          margin: EdgeInsets.only(top: 20.h),
                          decoration: BoxDecoration(
                            color: colors.textColor.withValues(alpha: .3),
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
                  Image.asset(
                    ImgAssets.aboutAppImage,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: colors.baseColor,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: colors.main, width: 1.2.r),
                    ),
                    child: Text(
                      'Cood هو تطبيق مبتكر يجمع بين مختلف منصات التواصل الاجتماعي في مكان واحد، مما يتيح للمستخدمين إدارة حساباتهم بسهولة وفعالية. يهدف التطبيق إلى تسهيل الوصول إلى جميع التطبيقات المفضلة لديك عبر واجهة موحدة، حيث يمكنك نشر المحتوى، عرض الإشعارات، والرد على الرسائل من جميع حساباتك دون الحاجة إلى التنقل بين تطبيقات متعددة.Cood يوفر تجربة موحدة ومنظمة تساعدك على توفير الوقت وزيادة إنتاجيتك أثناء استخدام وسائل التواصل الاجتماعي.',
                      style: TextStyles.regular16(
                        color: colors.blackColor,
                      ).copyWith(height: 2.3),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
