// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: colors.main.withValues(alpha: .1),
                offset: Offset(0, 5),
                blurRadius: 5),
          ],
          color: colors.baseColor,
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  icon,
                  color: colors.main,
                  height: 30.h,
                  width: 30.w,
                ),
                Gaps.hGap10,
                Text(title.tr,
                    style: TextStyles.semiBold14(color: colors.main)),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 25.r,
            ),
          ],
        ),
      ),
    );
  }
}
