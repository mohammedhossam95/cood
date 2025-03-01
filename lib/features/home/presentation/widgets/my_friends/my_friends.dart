// ignore_for_file: must_be_immutable

import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/features/reservations/domain/entity/contacts_entity.dart';
import 'package:cood/features/reservations/presentation/widgets/social_contact_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySocialFriends extends StatelessWidget {
   MySocialFriends({super.key});
  final List<ContactEntity> contacts = [
    ContactEntity(
        name: "عبدالله جمال",
        phone: "359698820",
        profileImage: 'assets/images/person.png'),
    ContactEntity(
        name: "أحمد المحمدي",
        phone: "359698845",
        profileImage: 'assets/images/person.png'),
    ContactEntity(
        name: "عبدالله جمال",
        phone: "359698820",
        profileImage: 'assets/images/person.png'),
    ContactEntity(
        name: "أحمد المحمدي",
        phone: "359698845",
        profileImage: 'assets/images/person.png'),
    ContactEntity(
        name: "عبدالله جمال",
        phone: "359698820",
        profileImage: 'assets/images/person.png'),
    ContactEntity(
        name: "أحمد المحمدي",
        phone: "359698845",
        profileImage: 'assets/images/person.png'),
    ContactEntity(
        name: "عبدالله جمال",
        phone: "359698820",
        profileImage: 'assets/images/person.png'),
    ContactEntity(
        name: "أحمد المحمدي",
        phone: "359698845",
        profileImage: 'assets/images/person.png'),
  ];
  @override
  Widget build(BuildContext context) {
  return  Expanded(
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: MyColors.upBackGround,
                borderRadius: BorderRadius.circular(25.r),
                boxShadow: [
                  BoxShadow(
                    color: MyColors.body.withValues(alpha: .5), // Shadow color
                    spreadRadius: 2.r, // Spread radius
                    blurRadius: 10.r, // Blur radius
                    offset: Offset(0, 3), // Offset in x and y directions
                  ),
                ],
              ),
              child: ListView.builder(
                  itemBuilder: (context, index) =>
                      ContactCard(contacts: contacts[index],isPhoneAppear: true,),
                  itemCount: contacts.length,
                ),
            ),
          ),
          Gaps.vGap20,
              //-----------------4
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Container(
                    width: 207.0.h,
                      margin: EdgeInsets.all(10.h),
                      child: MyDefaultButton(
                        onPressed: () {},
                        height: 50.h,
                        btnText: "add_friend",
                      ),
                    ),
                ],
              ),
        ],
      ),
    );
  }
}
