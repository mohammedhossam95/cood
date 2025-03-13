import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/values/assets.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../injection_container.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      decoration: BoxDecoration(
        color: colors.baseColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                color: colors.main,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Image.asset(
                ImgAssets.imagesEmail,
                width: 40.0.w,
                height: 40.0.h,
                color: colors.baseColor,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(14.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '50 رسالة بريدية جديدة!',
                    style: TextStyles.regular14(color: colors.blackColor),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  child: Text(
                    "منذ 3 ساعات",
                    style: TextStyles.regular12(
                        color: colors.blackColor.withValues(alpha: .5)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
