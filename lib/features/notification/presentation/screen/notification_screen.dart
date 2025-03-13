// ignore_for_file: unused_local_variable

import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/widgets/back_button.dart';
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
    bool isArabic = AppLocalizations.of(context)!.isArLocale;
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.backGround,
        body: Padding(
          padding: EdgeInsets.only(left: 25.0.w, right: 25.0.w, top: 40.0.w),
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Text(
                      'notifications'.tr,
                      style: TextStyles.bold32(color: colors.main),
                    ),
                  ),

                  //------backB
                  Align(
                     alignment:(isArabic)? Alignment.topRight: Alignment.topLeft,
                    child: CustomBackButton(),
                  ),
                  //CustomBackBotton(),
                ],
              ),
              Gaps.vGap35,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelect = 0;
                      });
                    },
                    child: Expanded(
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
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelect = 1;
                      });
                    },
                    child: Expanded(
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
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelect = 2;
                      });
                    },
                    child: Expanded(
                      child: SelectedNotificationItem(
                        itemBackground: isSelect == 2
                            ? colors.main
                            : colors.main.withValues(alpha: .12),
                        itemName: 'unReadableNotification',
                        textColor: isSelect == 2
                            ? colors.baseColor
                            : colors.blackColor,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => NotificationItemWidget(),
                  itemCount: 10,
                ),
              ),
            ],
          ),
        ),
        //),
      ),
    );
  }
}
