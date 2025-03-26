// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/convert_string_color.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/diff_img.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/show_dialog.dart';
import 'package:cood/features/home/domain/entities/all_social_media_entity.dart';
import 'package:cood/features/home/presentation/widgets/myAccounts/add_user_account_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllSocialContainerItem extends StatelessWidget {
  const AllSocialContainerItem({
    required this.allSocialAccount,
    super.key,
  });

  final AllSocialMediaEntity allSocialAccount;

  // Convert color code to a Color object

  @override
  Widget build(BuildContext context) {
    final Color itemColor =
        convertStringColor(allSocialAccount.color ?? '1877F2');
    return Container(
      decoration: BoxDecoration(
        color: itemColor.withValues(
          alpha: 0.1,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color:
              (itemColor == MyColors.socialYellow) ? MyColors.black : itemColor,
        ),
      ),
      margin: EdgeInsets.all(10.h),
      width: 348.w,
      height: 80.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Social icon
          Container(
            padding: EdgeInsets.all(16.r),
            width: 70.w,
            height: double.infinity,
            decoration: BoxDecoration(
              color: itemColor,
              borderRadius: (AppLocalizations.of(context)?.isArLocale ?? false)
                  ? BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(19.r),
                      bottomRight: Radius.circular(19.r),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(19.r),
                      topRight: Radius.circular(20.r),
                      bottomLeft: Radius.circular(19.r),
                    ),
            ),
            child: DiffImage(
              width: 40.0.w,
              height: 40.0.h,
              image: allSocialAccount.icon ?? '',
              userName: allSocialAccount.name ?? '',
            ),
          ),
          // Name and link
          SizedBox(
            width: 180.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  allSocialAccount.name ?? '',
                  style: TextStyles.bold14(),
                  maxLines: 2,
                ),
                InkWell(
                  onTap: () {
                    showAppDialog(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isDismissible: true,
                      child: AddUserAccountDialog(
                        color: itemColor,
                        id: allSocialAccount.id ?? 1,
                        image: allSocialAccount.icon ?? '',
                      ),
                    );
                  },
                  child: Text(
                    'addAccount'.tr,
                    style: TextStyles.bold14(),
                  ),
                ),
              ],
            ),
          ),
          // Menu icon
          Image.asset(
            'assets/images/Menu.png',
            color: (itemColor == MyColors.socialYellow)
                ? MyColors.black
                : itemColor,
          ),
          Gaps.hGap1,
        ],
      ),
    );
  }
}
