import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/features/reservations/domain/entity/communication_guide_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunicationGuideItem extends StatelessWidget {
  final   ComuniGuideItemEntity item;
  const CommunicationGuideItem({required this.item,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.backGround,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: MyColors.main,
        ),
      ),
      margin: EdgeInsets.all(10.h),
      width: 348.w,
      height: 80.h,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //----social icon
          Container(
            width: 70.w,
            height: double.infinity,
            decoration: BoxDecoration(
              color: MyColors.main,
              borderRadius: (AppLocalizations.of(context)!.isArLocale)?BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(19.r),
                bottomRight: Radius.circular(19.r),
              ):BorderRadius.only(
                topLeft: Radius.circular(19.r),
                topRight: Radius.circular(20.r),
                bottomLeft: Radius.circular(19.r),
              ),
            ),
            child: Image.asset(
                item.image!),
          ),
          Gaps.hGap20,
          //---------name & email

          Text(
            item.title!,
            style: TextStyles.bold14(),
            //maxLines: 2,
          ),
          //------menue
        ],
      ),
    );
  }
}
