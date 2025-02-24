// ignore_for_file: use_super_parameters

import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactCard extends StatefulWidget {
  const ContactCard({Key? key}) : super(key: key);

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
          decoration: BoxDecoration(
            color: MyColors.backGround,
            borderRadius: AppLocalizations.of(context)!.isArLocale
                ? BorderRadius.only(
                    topLeft: Radius.circular(20.0.r),
                    bottomLeft: Radius.circular(20.0.r),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(20.0.r),
                    bottomRight: Radius.circular(20.0.r),
                  ),
          ),
          height: isExpanded ? 200 : 80,
          width: 280,
          margin: EdgeInsets.only(
            top: 8.0.h,
            right: AppLocalizations.of(context)!.isArLocale ? 70.0.w : 0.0,
            left: AppLocalizations.of(context)!.isArLocale ? 0.0 : 70.0.w,
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding:
                    EdgeInsets.only(left: 20.w, right: 20.0.w, top: 8.0.h),
                title: Text('علي لطفي',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('02555222222'),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          CircleAvatar(
                            backgroundColor: MyColors.errorColor,
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.white),
                              onPressed: null,
                            ),
                          ),
                          Icon(Icons.facebook, color: Colors.pink, size: 30),
                          Icon(Icons.tiktok, color: Colors.black, size: 30),
                          Icon(Icons.snapchat, color: Colors.yellow, size: 30),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(Icons.facebook,
                              color: Colors.blue, size: 30),
                          const Icon(Icons.facebook,
                              color: Colors.green, size: 30),
                          IconButton(
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
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          right: AppLocalizations.of(context)!.isArLocale ? 40.0.w : null,
          left: AppLocalizations.of(context)!.isArLocale ? null : 40.0.w,
          top: 8.0.h,
          child: Container(
            width: 30.w,
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
                image: AssetImage('assets/images/detail item.png'),
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
