import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/values/text_styles.dart';
import '../../../../injection_container.dart';
import '../widget/notification_item.dart';
import '../widget/select_notifcation_status_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  num isSelect = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.backGround,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'notifications'.tr,
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
                Gaps.vGap64,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelect = 0;
                        });
                      },
                      child: SelectedNotificationItem(
                        itemBackground: isSelect == 0
                            ? colors.main
                            : colors.main.withValues(alpha: .12),
                        itemName: 'all',
                        textColor: isSelect == 0
                            ? colors.baseColor
                            : colors.blackColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelect = 1;
                        });
                      },
                      child: SelectedNotificationItem(
                        itemBackground: isSelect == 1
                            ? colors.main
                            : colors.main.withValues(alpha: .12),
                        itemName: 'readableNotification',
                        textColor: isSelect == 1
                            ? colors.baseColor
                            : colors.blackColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelect = 2;
                        });
                      },
                      child: SelectedNotificationItem(
                        itemBackground: isSelect == 2
                            ? colors.main
                            : colors.main.withValues(alpha: .12),
                        itemName: 'illegibleNotification',
                        textColor: isSelect == 2
                            ? colors.baseColor
                            : colors.blackColor,
                      ),
                    )
                  ],
                ),
                Gaps.vGap30,
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => NotificationItemWidget(),
                  itemCount: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
