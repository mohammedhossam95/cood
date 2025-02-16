import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunicationDetailsItem extends StatelessWidget {
  const CommunicationDetailsItem({super.key});

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
      margin: EdgeInsets.only(left: 20.w,right: 20.w,bottom:10.h),
      width: 348.w,
      height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //----
          Container(
            width: 70.w,
            height: double.infinity,
            decoration: BoxDecoration(
              color: MyColors.main,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            child: Image.asset(
              'assets/images/detail item.png',fit: BoxFit.fill,),
              
          ),
          //---------name & email
          SizedBox(
            width: 180.w,
            child: Text(
              'عبد الله جمال',
              style: TextStyles.bold14(),
              //maxLines: 2,
            ),
          ),
          //------menue
          Image.asset(
            'assets/images/Back.png',
          ),
          Gaps.hGap1,
        ],
      ),
    );
  }
}
