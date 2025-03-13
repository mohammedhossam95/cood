import 'package:cood/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/values/text_styles.dart';
import '../../../../injection_container.dart';

class SelectedNotificationItem extends StatelessWidget {
  final Color itemBackground;
  final Color textColor;
  final String itemName;
  const SelectedNotificationItem({
    super.key,
    required this.itemBackground,
    required this.textColor,
    required this.itemName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0.w,
      height: 45.0.h,
      decoration: BoxDecoration(
          color: itemBackground,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: colors.main, width: 2.r)),
      child: Center(
        child: Text(
          itemName.tr,
          style: TextStyles.regular16(color: textColor),
        ),
      ),
    );
  }
}
