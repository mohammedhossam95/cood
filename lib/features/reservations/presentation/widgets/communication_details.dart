import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/back_button.dart';
import 'package:cood/features/reservations/presentation/widgets/social_contact_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


//main page for communication details

class CommunicationItemDetails extends StatefulWidget {
  const CommunicationItemDetails({super.key});

  @override
  State<CommunicationItemDetails> createState() =>
      _CommunicationItemDetailsState();
}

class _CommunicationItemDetailsState extends State<CommunicationItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: MyColors.backGround,
      body: Column(
        children: [
          Container(
            height: 300.h,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/car2.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 50.0.h,
                        left: 30.0.w), // Adjust padding for placement
                    child: CustomBackButton(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.h), // Optional padding
                    child: Text(
                      'السيارات',
                      style: TextStyles.bold32().copyWith(
                        color: MyColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            //------------------this need to be custom and change photo to extract out the container built in row
            child: Container(
              margin: EdgeInsets.only(top: 15.h),
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.r),
                    topRight: Radius.circular(35.r),
                ),
              ),
              child: ListView.builder(itemBuilder: (context,index)=>ContactCard(),itemCount:2 ,),
            ),
          )
        ],
      ),
    );
  }
}
