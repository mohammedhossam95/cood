import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/back_button.dart';
import 'package:cood/features/reservations/domain/entity/contacts_entity.dart';
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
    bool isArabic = AppLocalizations.of(context)!.isArLocale;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: MyColors.backGround,
        body: Column(
          children: [
            Container(
              height: 221.h,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/car2.png',),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: [
                  (isArabic)?
                  Positioned(
                    top: 15.0.h,
                    right: 15.0.h,
                    child: CustomBackButton(),
                  ):Positioned(
                    top: 15.0.h,
                    left: 15.0.h,
                    child: CustomBackButton(),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0.h), // Optional padding
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
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      ContactCard(contacts: contacts[index]),
                  itemCount: contacts.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
