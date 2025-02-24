// ignore_for_file: use_super_parameters

import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/features/reservations/domain/entity/contacts_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactCard extends StatefulWidget {
  final ContactEntity contacts;
  const ContactCard({Key? key,required this.contacts}) : super(key: key);

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Container(
          height: isExpanded ? 220.0.h : 80.0.h,
          width: 280.w,
          decoration: BoxDecoration(
            color: MyColors.backGround,
            borderRadius: AppLocalizations.of(context)!.isArLocale
                ? BorderRadius.only(
                    topLeft: Radius.circular(20.0.r),
                    bottomLeft: Radius.circular(20.0.r),
                    bottomRight: (isExpanded)?Radius.circular(20.0.r):Radius.circular(0.0.r),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(20.0.r),
                    bottomRight: Radius.circular(20.0.r),
                    bottomLeft: (isExpanded)?Radius.circular(0.0.r):Radius.circular(20.0.r),
                  ),
          ),
          margin: EdgeInsets.only(
            top: 10.0.h,
            right: AppLocalizations.of(context)!.isArLocale ? 70.0.w : 0.0.w,
            left: AppLocalizations.of(context)!.isArLocale ? 0.0.w : 70.0.w,
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding:
                    EdgeInsets.only(left: 20.w, right: 20.0.w, top: 8.0.h),
                title: Text('${widget.contacts.name}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${widget.contacts.phone}'),
                trailing: isExpanded
                    ? SizedBox()
                    : IconButton(
                        icon: Icon(
                          size: 40.0.h,
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        ),
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                      ),
              ),
              if (isExpanded)
                Padding(
                  padding:  EdgeInsets.symmetric(
                      horizontal: 16.0.w, vertical: 8.0.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //------------------------1 snapchat
                          CircleAvatar(
                            radius: 25.0.r,
                            backgroundColor: MyColors.socialyellow,
                            child: Image.asset(
                              'assets/images/snapchat.png',
                              height: 30.0.h,
                            ),
                          ), //------------------------2 tiktok
                          CircleAvatar(
                            radius: 25.0.r,
                            backgroundColor: MyColors.black,
                            child: Image.asset(
                              'assets/images/tiktok.png',
                              height: 30.0.h,
                            ),
                          ), //------------------------3  insta
                          Container(
                            height: 50.h,
                            width: 50.0.w,
                            decoration: BoxDecoration(
                              shape: BoxShape
                                  .circle, // Circle shape for Instagram-style avatars
                              gradient: LinearGradient(
                                colors: [
                                  MyColors.pink,
                                  MyColors.purple,
                                  MyColors.orange,
                                  MyColors.yellow,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Image.asset('assets/images/Instagram.png'),
                          ),

                          //------------------------4
                          Container(
                            width: 60.0.w,
                            height: 40.0.h,
                            decoration: BoxDecoration(
                              color: MyColors.errorColor,
                              borderRadius: BorderRadius.circular(15.0.r),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.white),
                              onPressed: null,
                            ),
                          ),
                        ],
                      ),
                       Gaps.vGap12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //-------------5 whatsApp
                          CircleAvatar(
                            radius: 25.0.r,
                            backgroundColor: MyColors.socialGreen,
                            child: Image.asset(
                              'assets/images/Whatsapp 1.png',
                              height: 30.0.h,
                            ),
                          ),
                          //---------------6 facbook
                          CircleAvatar(
                            radius: 25.0.r,
                            backgroundColor: MyColors.main,
                            child: Image.asset(
                              'assets/images/facbook.png',
                              height: 30.0.h,
                            ),
                          ),
                          //--------------------------7 imo
                          CircleAvatar(
                            radius: 25.0.r,
                            backgroundImage: AssetImage('assets/images/imo.png'),
                          ),
                          //-------------------------8 dropdwon button
                          SizedBox(
                            height: 50.0.h,
                            width: 50.0.w,
                            child: IconButton(
                              icon: Icon(
                                size: 50.0.h,
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                              ),
                              onPressed: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        //---------this container to decorate image the angel between image ang bigger container
        Positioned(
          right: AppLocalizations.of(context)!.isArLocale ? 40.0.w : null,
          left: AppLocalizations.of(context)!.isArLocale ? null : 40.0.w,
          top: 10.0.h,//the same the bigger container margin
          child: Container(
            width: 35.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: MyColors.backGround,
            ),
          ),
        ),
        Positioned(
          right: AppLocalizations.of(context)!.isArLocale ? 0.0.w : null,
          left: AppLocalizations.of(context)!.isArLocale ? null : 0.0.w,
          top: 8.0.h,
          child: Container(
            width: 70.w,
            height: 80.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('${widget.contacts.profileImage}'),
                fit: BoxFit.cover,
              ),
              borderRadius: (AppLocalizations.of(context)!.isArLocale)
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
          ),
        ),
      ],
    );
  }
}
