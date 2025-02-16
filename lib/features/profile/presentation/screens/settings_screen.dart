import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/values/assets.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/gaps.dart';
import '../../../../injection_container.dart';
import '../../../more/presentation/widgets/more_item_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.backGround,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'settings'.tr,
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
              Gaps.vGap100,
              Text(
                'my_profile'.tr,
                style: TextStyles.bold24(color: colors.main),
              ),
              Gaps.vGap20,
              ListTile(
                minVerticalPadding: 0,
                leading: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    color: colors.main,
                    border: Border.all(
                      color: colors.main,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      "assets/images/user.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  'فهد سليمان',
                  style: TextStyles.bold15(color: colors.main),
                ),
                subtitle: Text(
                  '+966 55 555 5555',
                  style: TextStyles.bold15(color: colors.main),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 25.r,
                  color: colors.blackColor,
                ),
              ),
              Divider(
                color: colors.main,
                thickness: 2.h,
              ),
              Gaps.vGap8,
              Text(
                'settings'.tr,
                style: TextStyles.bold20(color: colors.main),
              ),
              Gaps.vGap8,
              MoreItemWidget(
                onTap: () {
                  Navigator.pushNamed(context, Routes.editProfileScreenRoute);
                },
                icon: ImgAssets.editMyProfileIcon,
                title: 'editMyProfile',
              ),
              Gaps.vGap12,
              MoreItemWidget(
                onTap: () {},
                icon: ImgAssets.myNotificationsIcon,
                title: 'notifications',
              ),
              Gaps.vGap12,
              MoreItemWidget(
                onTap: () {},
                icon: ImgAssets.myInfoIcon,
                title: 'about_app',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
