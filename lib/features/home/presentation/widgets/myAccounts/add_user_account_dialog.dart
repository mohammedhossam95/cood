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
  final int id;
  final Color color;
  final String? image;
  const AddUserAccountDialog({
    super.key,
    required this.id,
    required this.color,
    this.image,
  });

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
            top: 45.h,
            left: 0,
            right: 0,
            bottom: 5.h,
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.circular(20.0.r),
              ),
              child: Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(
                    0.1,
                  ),
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
                      color: widget.color,
                      textColor: widget.color == MyColors.socialYellow
                          ? MyColors.black
                          : MyColors.white,
                    ),
                  ],
                ),
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
                color: widget.color,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: DiffImage(
                  width: 50.w,
                  height: 50.h,
                  image: widget.image ??
                      'https://cood.testworks.top/storage/social-media-icons/1ojm33Ez9jem0ysLxrLzKBk2KCq2YCi6iWtU02Z4.png',
                  //userName: 'image',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
