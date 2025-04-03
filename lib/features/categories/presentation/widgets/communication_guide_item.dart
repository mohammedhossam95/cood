// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/diff_img.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/features/categories/domain/entity/category_entity.dart';
import 'package:cood/injection_container.dart';

class CommunicationGuideItem extends StatelessWidget {
  final CategoryEntity item;
  bool isAddButton;

  CommunicationGuideItem({
    super.key, 
    required this.item,
    this.isAddButton = false,

  });

  @override
  Widget build(BuildContext context) {
    bool isArabic = AppLocalizations.of(context)!.isArLocale;
    return Container(
      decoration: BoxDecoration(
        color: MyColors.backGround,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: colors.main,
        ),
      ),
      margin: EdgeInsets.all(10.h),
      height: 80.h,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //----social icon
          Container(
            width: 80.w,
            height: double.infinity,
            decoration: BoxDecoration(
              color: MyColors.main,
              borderRadius: (isArabic)
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
            child: Center(
              child: DiffImage(
                image: item.icon ?? '',
                width: 50.0.w,
                height: 50.0.h,
              ),
            ),
          ),
          Gaps.hGap20,
          //---------name & email

          Expanded(
            child: Text(
              (isArabic) ? item.nameAr ?? '' : item.nameEn ?? '',

              style: TextStyles.bold14(),
              //maxLines: 2,
            ),
          ),
          //------menue
          if (isAddButton)
             Container(
                height: 45.h,
                width: 45.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Sum.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              
            ),
          Gaps.hGap20,
        ],
      ),
    );
  }
}
