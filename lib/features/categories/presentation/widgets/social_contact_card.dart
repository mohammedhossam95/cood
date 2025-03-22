// ignore_for_file: use_super_parameters

import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/constants.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/utils/values/assets.dart';
import 'package:cood/core/utils/values/luanche_url_method.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/diff_img.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/features/categories/domain/entity/category_user_entity.dart';
import 'package:cood/features/categories/presentation/widgets/social_contact_card_custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ContactCard extends StatefulWidget {
  final CategoryUserEntity contacts;
  bool isPhoneAppear;
  ContactCard({super.key, required this.contacts, this.isPhoneAppear = false});

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    bool isArabic = AppLocalizations.of(context)!.isArLocale;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            margin: (isArabic)
                ? EdgeInsets.only(
                    top: 10.0.h,
                    right: 80.0.w,
                    left: 20.0.w,
                  )
                : EdgeInsets.only(
                    top: 10.0.h,
                    right: 20.0.w,
                    left: 80.0.w,
                  ),
            height: isExpanded ? 180.0.h : 65.0.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: MyColors.backGround,
              borderRadius: (isArabic)
                  ? BorderRadius.only(
                      topLeft: Radius.circular(20.0.r),
                      bottomLeft: Radius.circular(20.0.r),
                      bottomRight: (isExpanded)
                          ? Radius.circular(20.0.r)
                          : Radius.circular(0.0.r),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(20.0.r),
                      bottomRight: Radius.circular(20.0.r),
                      bottomLeft: (isExpanded)
                          ? Radius.circular(0.0.r)
                          : Radius.circular(20.0.r),
                    ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: isArabic ? 0.0.w : 20.0.w,
                        right: isArabic ? 20.0.w : 0.0.w,
                        top: 8.0.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.contacts.name}',
                            style: TextStyles.bold12(),
                          ),
                          if (widget.isPhoneAppear)
                            Text(
                              '${widget.contacts.phone}',
                              style: TextStyles.bold12(),
                            ),
                        ],
                      ),
                    ),
                    //-------dropDown part
                    (isExpanded)
                        ? SizedBox()
                        : IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 50.0.h,
                              color: MyColors.highlight,
                            ),
                            onPressed: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                          ),
                  ],
                ),
                (widget.isPhoneAppear) ? Gaps.vGap2 : Gaps.vGap16,
                if (isExpanded)
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0.w, vertical: 8.0.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //------------------------1 snapchat
                            CustomIconWidget(
                              shape: BoxShape.circle,
                              backgroundColor: MyColors.socialYellow,
                              childImagePath: ImgAssets.snapChatImg,
                              onPressed: () {
                                onLaunche(
                                    widget.contacts.socialMediaLinks?[2].link ??
                                        '',
                                    context);
                              },
                            ),

                            //------------------------2 tiktok
                            CustomIconWidget(
                              shape: BoxShape.circle,
                              backgroundColor: MyColors.black,
                              childImagePath: ImgAssets.tiktokImg,
                              onPressed: () {
                                onLaunche(
                                    widget.contacts.socialMediaLinks?[1].link ??
                                        '',
                                    context);
                              },
                            ),

                            //------------------------3  insta
                            CustomIconWidget(
                              shape: BoxShape.circle,
                              backgroundColor: MyColors.black,
                              childImagePath: ImgAssets.instaImg,
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
                              onPressed: () {},
                            ),

                            //------------------------4 delete
                            CustomIconWidget(
                              width: 60.0.w,
                              height: 40.0.h,
                              shape: BoxShape.rectangle,
                              radius: 15.0.r,
                              backgroundColor: MyColors.errorColor,
                              childImagePath: ImgAssets.trashImg,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Gaps.vGap8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //-------------5 whatsApp
                            CustomIconWidget(
                              backgroundColor: MyColors.socialGreen,
                              childImagePath: ImgAssets.whatsAppImg,
                              onPressed: () {},
                            ),

                            //---------------6 facbook
                            CustomIconWidget(
                              backgroundColor: MyColors.main,
                              childImagePath: ImgAssets.facbookImg,
                              onPressed: () {
                                onLaunche(
                                    widget.contacts.socialMediaLinks?[0].link ??
                                        '',
                                    context);
                              },
                            ),

                            //--------------------------7 imo
                            CustomIconWidget(
                              backgroundColor: MyColors.main,
                              backgroundImage: ImgAssets.imoImg,
                              onPressed: () {},
                            ),

                            //-------------------------8 dropdwon button
                            SizedBox(
                              height: 50.0.h,
                              width: 50.0.w,
                              child: IconButton(
                                icon:
                                    Icon(size: 50.0.h, Icons.keyboard_arrow_up),
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
        ),
        //---------this container to decorate image the angel between image ang bigger container
        Positioned(
          right: (isArabic) ? 45.0.w : null,
          left: (isArabic) ? null : 45.0.w,
          top: 10.0.h, //the same the bigger container margin
          child: Container(
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: MyColors.backGround,
            ),
          ),
        ),
        //-------------sliver List Image
        Positioned(
          right: (isArabic) ? 17.0.w : null,
          left: (isArabic) ? null : 17.0.w,
          top: 10.0.h,
          child: SizedBox(
            width: 65.w,
            height: 65.h,
            child: DiffImage(
              image: widget.contacts.image ?? nullNetworkImage,
              fitType: BoxFit.cover,
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
          ),
        ),
      ],
    );
  }
}
