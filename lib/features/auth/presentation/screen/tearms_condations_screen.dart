import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../injection_container.dart';

class TearmsCondationsScreen extends StatelessWidget {
  const TearmsCondationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backGround,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        'policyAndTerms'.tr,
                        style: TextStyles.bold24(color: colors.main),
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
                Gaps.vGap30,
                Text(
                  'abstract'.tr,
                  style: TextStyles.bold24(color: colors.main),
                ),
                Gaps.vGap4,
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: colors.upBackGround,
                    border: Border.all(color: colors.main),
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Text(
                    'باستخدام تطبيق Cood، فإنك توافق على الالتزام بالشروط التي تشمل الاستخدام القانوني، حماية الخصوصية، وحقوق الملكية الفكرية. يحق للتطبيق إجراء تحديثات وإنهاء الخدمة في حالة الانتهاكات، وتُطبق الشروط وفق قوانين الدولة المعنية.',
                    style: TextStyles.regular16(color: colors.textColor),
                  ),
                ),
                Gaps.vGap10,
                Text(
                  'terms'.tr,
                  style: TextStyles.bold24(color: colors.main),
                ),
                Gaps.vGap4,
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: colors.upBackGround,
                    border: Border.all(color: colors.main),
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Text(
                    'باستخدام تطبيق Cood، فإنك توافق على الالتزام بالشروط التي تشمل الاستخدام القانوني، حماية الخصوصية، وحقوق الملكية الفكرية. يحق للتطبيق إجراء تحديثات وإنهاء الخدمة في حالة الانتهاكات، وتُطبق الشروط وفق قوانين الدولة المعنية.باستخدام تطبيق Cood، فإنك توافق على الالتزام بالشروط التي تشمل الاستخدام القانوني، حماية الخصوصية، وحقوق الملكية الفكرية. يحق للتطبيق إجراء تحديثات وإنهاء الخدمة في حالة الانتهاكات، وتُطبق الشروط وفق قوانين الدولة المعنية.باستخدام تطبيق Cood، فإنك توافق على الالتزام بالشروط التي تشمل الاستخدام القانوني، حماية الخصوصية، وحقوق الملكية الفكرية. يحق للتطبيق إجراء تحديثات وإنهاء الخدمة في حالة الانتهاكات، وتُطبق الشروط وفق قوانين الدولة المعنية.باستخدام تطبيق Cood، فإنك توافق على الالتزام بالشروط التي تشمل الاستخدام القانوني، حماية الخصوصية، وحقوق الملكية الفكرية. يحق للتطبيق إجراء تحديثات وإنهاء الخدمة في حالة الانتهاكات، وتُطبق الشروط وفق قوانين الدولة المعنية.',
                    style: TextStyles.regular16(color: colors.textColor),
                  ),
                ),
                Gaps.vGap30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyDefaultButton(
                      onPressed: () {
                       Navigator.pop(context);
                      },
                      borderColor: colors.main,
                      btnText: 'acceptButton',
                      width: 120.w,
                      height: 40.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 120.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: colors.backGround,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: colors.main),
                        ),
                        child: Center(
                          child: Text(
                            'dejectButton'.tr,
                            style:
                                TextStyles.regular18(color: colors.blackColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.vGap40,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
