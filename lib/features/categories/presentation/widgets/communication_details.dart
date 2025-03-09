import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/back_button.dart';
import 'package:cood/features/categories/domain/entity/contacts_entity.dart';
import 'package:cood/features/categories/presentation/widgets/social_contact_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        backgroundColor: MyColors.backGround,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0.0,
              backgroundColor: MyColors.main,
              expandedHeight: 240.h,
              pinned: true,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/car2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),

                  ///this stack only for custom back button
                  child: Stack(
                    children: [
                      if (isArabic)
                        Positioned(
                          top: 15.0.h,
                          right: 15.0.h,
                          child: CustomBackButton(),
                        )
                      else
                        Positioned(
                          top: 15.0.h,
                          left: 15.0.h,
                          child: CustomBackButton(),
                        ),
                    ],
                  ),
                ),
                title: Text(
                  'السيارات', // Title to show when pinned
                  style: TextStyles.bold20().copyWith(
                    color: MyColors.white,
                  ),
                ),
                centerTitle: true,
              ),
            ),
            
            // Rounded top container
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 15.0.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0.r),
                    topRight: Radius.circular(25.0.r),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.white,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          ContactCard(contacts: contacts[index]),
                      itemCount: contacts.length,
                    ),
                  ),
                ),
              ),
            ),

            // List of contacts
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) => ContactCard(contacts: contacts[index]),
            //     childCount: contacts.length,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
