import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../injection_container.dart';

class MoreFeesContainer extends StatelessWidget {
  const MoreFeesContainer(
      {super.key,
      required this.title,
      required this.check,
      required this.fees,
      required this.onCheck});
  final String title;
  final String fees;
  final bool check;
  final VoidCallback onCheck;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.h),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.dividerColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // InkWell(
          //   onTap: onCheck,
          //   child:
          AnimatedContainer(
            height: 20.h,
            width: 20.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (check) ? colors.main : null,
              border: Border.all(
                width: 2,
                color: (check)
                    ? colors.main
                    : colors.textColor.withValues(alpha: 0.5),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(milliseconds: 100),
            child: check
                ? Icon(
                    Icons.check,
                    size: 16.r,
                    color: colors.backGround,
                  )
                : null,
          ),
          // ),
          Text(
            title,
            style: TextStyles.bold14(
              color: colors.textColor.withValues(alpha: 0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "$fees ${'reyal'.tr}",
              style: TextStyles.bold14(
                color: colors.textColor.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
