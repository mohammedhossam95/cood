import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/features/home/domain/entities/social_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialContainerItem extends StatelessWidget {
  const SocialContainerItem(
      {required this.entityModel,
       this.socialPhotoColors=MyColors.main,
      this.socialBackgroundColors = MyColors.lightTextColor,
      super.key});
  final SocialEntity entityModel;
  final Color socialPhotoColors;
  final Color socialBackgroundColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: socialBackgroundColors,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: (socialPhotoColors == MyColors.socialyellow)
              ? MyColors.black
              : socialPhotoColors,
        ),
      ),
      margin: EdgeInsets.all(10.h),
      width: 348.w,
      height: 80.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //----social icon
          Container(
            width: 70.w,
            height: double.infinity,
            decoration: BoxDecoration(
              color: socialPhotoColors,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            child: Image.asset(entityModel.image!),
          ),
          //---------name & email
          SizedBox(
            width: 180.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  entityModel.name!,
                  style: TextStyles.bold14(),
                  maxLines: 2,
                ),
                Text(
                  entityModel.email!,
                  style: TextStyles.bold14(),
                ),
              ],
            ),
          ),
          //------menue
          Image.asset(
            'assets/images/Menu.png',
            color: (socialPhotoColors == MyColors.socialyellow)
                ? MyColors.black
                : socialPhotoColors,
          ),
          Gaps.hGap1,
        ],
      ),
    );
  }
}
