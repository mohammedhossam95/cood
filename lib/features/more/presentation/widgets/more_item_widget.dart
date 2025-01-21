// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/injection_container.dart';

class MoreItemWidget extends StatelessWidget {
  const MoreItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title, icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: const Color(0xffF4E5FF),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: colors.main,
              height: 24.h,
              width: 24.w,
            ),
            Gaps.hGap10,
            Text(title.tr, style: TextStyles.regular14(color: colors.main)),
          ],
        ),
      ),
    );
  }
}
