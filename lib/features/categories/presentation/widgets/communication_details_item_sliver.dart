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

  // Scroll controller to track scroll position
  final ScrollController _scrollController = ScrollController();
  bool _isSliverAppBarPinned = false;

  @override
  void initState() {
    super.initState();
    // Listen to scroll events
    _scrollController.addListener(() {
      setState(() {
        // Check if the scroll offset is greater than the expanded height of the SliverAppBar
        _isSliverAppBarPinned = _scrollController.offset > (221.h - kToolbarHeight);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the scroll controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = AppLocalizations.of(context)!.isArLocale;

    return SafeArea(
      child: Scaffold(
        //backgroundColor: MyColors.arrowBackGrey,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: MyColors.main,
              expandedHeight: 221.h,
              pinned: true,
              automaticallyImplyLeading: false,
              title: _isSliverAppBarPinned
                  ? Text(
                      'السيارات', // Title to show when pinned
                      style: TextStyles.bold20().copyWith(
                        color: MyColors.white,
                      ),
                    )
                  : null, // No title when expanded
              centerTitle: true, // Center the title
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/car2.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
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
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10.0.h),
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
              ),
            ),
            
            // Rounded top container
          
            
            // List of contacts
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ContactCard(contacts: contacts[index]),
                childCount: contacts.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}