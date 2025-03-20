// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/convert_string_color.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/diff_img.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/features/home/domain/entities/user_social_media_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialContainerItem extends StatelessWidget {
  const SocialContainerItem({
    required this.socialAccount,
    super.key,
  });

  final SocialMediaEntity socialAccount;
  


  @override
  Widget build(BuildContext context) {
    final Color itemColor =
        convertStringColor(socialAccount.color ?? '1877F2');
    return  Container(
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: itemColor.withOpacity(0.1,),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: (itemColor == MyColors.socialYellow)
                ? MyColors.black
                : itemColor,
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
              padding: EdgeInsets.all(10.r),
              width: 70.w,
              height: double.infinity,
              decoration: BoxDecoration(
                color: itemColor,
                borderRadius:
                    (AppLocalizations.of(context)?.isArLocale ?? false)
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
                width: 50.0.w,
                height:50.0.h,
                image: socialAccount.icon ?? '',
                userName: socialAccount.platform ?? '',
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
                    socialAccount.platform ?? '',
                    style: TextStyles.bold14(),
                    maxLines: 2,
                  ),
                  GestureDetector(//lanuch url
                    onTap: () {
                      final url = socialAccount.link;
                      onLaunche(url ?? '', context);
                    },
                    child: Text(
                      'clickToViewProfile'.tr,
                      style:TextStyles.bold14(),
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

  Future<void> onLaunche(String url, context) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
}
