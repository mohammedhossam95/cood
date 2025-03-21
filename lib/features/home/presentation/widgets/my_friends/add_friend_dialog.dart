// ignore_for_file: avoid_print

import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/core/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddFriendDialog extends StatefulWidget {
  const AddFriendDialog({super.key});

  @override
  State<AddFriendDialog> createState() => _AddFriendDialogState();
}

class _AddFriendDialogState extends State<AddFriendDialog> {
  final TextEditingController addFriendController = TextEditingController();

  List<String> searchResults = ['Ali lotfy sharf eldin ', 'Ahmed', 'mohamed', 'ibrahim'];
  List<String> filteredResults = [];
  bool isHasResult = false;

  void _onSearch(String? value) {
    if (!mounted) return;

    setState(() {
      if (value == null || value.trim().isEmpty) {
        // If the search query is empty, reset the filtered results
        filteredResults = [];
        isHasResult = false;
      } else {
        // Filter the results based on the search query
        filteredResults = searchResults
            .where((result) =>
                result.toLowerCase().contains(value.trim().toLowerCase()))
            .toList();
        isHasResult = filteredResults.isNotEmpty;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = AppLocalizations.of(context)!.isArLocale;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'addFriend'.tr,
              style: TextStyles.bold24(color: MyColors.main),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 20.0.w,
                right: 20.0.w,
                bottom: 10.0.h,
              ),
              child: Divider(
                color: MyColors.main,
              ),
            ),
            MySearchBar(
              controller: addFriendController,
              hintText: 'searchByCodeNumber'.tr,
              focusNode: FocusNode(),
              onTap: _onSearch,
              autoComplete: true,
              //onSubmit:_onSearch ,
            ),
            const SizedBox(height: 10),
            if (isHasResult)
              SizedBox(
                height: 150.h,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredResults.length,
                    itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.all(10.0.h),
                          width: double.infinity,
                          height: 55.0.h,
                          decoration: BoxDecoration(
                              color: MyColors.backGround,
                              borderRadius: BorderRadius.circular(12.0.r),
                              border: Border.all(
                                color: MyColors.black,
                              )),
                          child: Row(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // First: Container with Image
                              ClipRRect(
                                borderRadius: isArabic
                                    ?  BorderRadius.only(
                                        topLeft: Radius.circular(12.0.r),
                                        topRight: Radius.circular(9.0.r),
                                        bottomRight: Radius.circular(9.0.r),
                                      )
                                    :  BorderRadius.only(
                                        topLeft: Radius.circular(9.0.r),
                                        topRight: Radius.circular(12.0.r),
                                        bottomLeft: Radius.circular(9.0.r),
                                      ),
                                child: Container(
                                  width: 55.0.w, // Width of the image container
                                  height: 55.0.h, // Height of the image container
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:AssetImage(
                                          'assets/images/person.png'), // Use NetworkImage or AssetImage
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Gaps.hGap12, // Spacing between image and text
                              
                               Expanded(
                                   child: Text(
                                      filteredResults[index],
                                      style: TextStyles.bold14(),
                                      maxLines: 2,
                                    ),
                                 ),
                               
                              
                              // Third: Button with Text (Add)
                              MyDefaultButton(
                                height: 35.0.h,
                                width: 75.0.w,
                                btnText: 'add',
                                borderRadius:10.0.r,
                                onPressed: (){},
                                ),
                                Gaps.hGap8,
                            ],
                          ),
                        ),
                        ),
              )
            else
              Padding(
                padding: EdgeInsets.only(top: 8.0.h),
                child: Text(
                  'noResult'.tr,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
