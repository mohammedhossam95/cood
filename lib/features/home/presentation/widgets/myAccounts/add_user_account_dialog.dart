// ignore_for_file: avoid_print, unused_local_variable, sized_box_for_whitespace

import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/widgets/defult_text_field.dart';
import 'package:cood/core/widgets/diff_img.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddUserAccountDialog extends StatefulWidget {
  const AddUserAccountDialog({super.key});

  @override
  State<AddUserAccountDialog> createState() => _AddUserAccountDialogState();
}

class _AddUserAccountDialogState extends State<AddUserAccountDialog> {
  final TextEditingController addUserAccountController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isArabic = AppLocalizations.of(context)!.isArLocale;
    return SizedBox(
      height: 224.h,
      width: 348.w,
      child: Stack(
        children: [
//------------------------------------1
          Positioned(
            top: 50.h,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 230, 196, 196),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15.r),
                ),
              ),
              child: Column(
                children: [
                  // Input Field
                  Gaps.vGap30,
                  MyTextFormField(
                    controller: addUserAccountController,
                    hintText: 'addLink'.tr, // For localization
                    focusNode: FocusNode(),
                    keyboardType: TextInputType.text,
                  ),
                  Gaps.vGap20,
                  // Save Button
                  MyDefaultButton(
                    onPressed: () {
                      //ToDo post method
                      //----consume cubit
                      //post(id,addUserAccountController);
                    },
                    height: 44.h,
                    width: 128.w,
                    btnText: "save", // For localization
                    color: MyColors.errorColor,
                  ),
                  Gaps.vGap10,
                ],
              ),
            ),
          ),
          //----------2
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: MyColors.errorColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: DiffImage(
                  width: 50.w,
                  height: 50.h,
                  image:
                      'https://cood.testworks.top/storage/social-media-icons/8EEzhsMW69i60QuEPD2N41GzgvSiNnPrENcMrYzc.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
