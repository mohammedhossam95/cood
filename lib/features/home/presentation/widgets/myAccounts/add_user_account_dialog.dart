// ignore_for_file: avoid_print, unused_local_variable, sized_box_for_whitespace, deprecated_member_use, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:animate_do/animate_do.dart';
import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/params/add_user_account.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/defult_text_field.dart';
import 'package:cood/core/widgets/diff_img.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/features/home/presentation/cubit/add_user_social_account/add_user_social_account_cubit.dart';
import 'package:cood/features/home/presentation/cubit/add_user_social_account/add_user_social_account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddUserAccountDialog extends StatefulWidget {
  final int id;
  final Color color;
  final String image;
  const AddUserAccountDialog({
    super.key,
    required this.id,
    required this.color,
    required this.image,
  });

  @override
  State<AddUserAccountDialog> createState() => _AddUserAccountDialogState();
}

class _AddUserAccountDialogState extends State<AddUserAccountDialog> {
  final TextEditingController addUserAccountController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    BlocProvider.of<AddUserSocialAccountCubit>(context).emitIntial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = AppLocalizations.of(context)!.isArLocale;
    AddAccountParams param = AddAccountParams();

    return ZoomIn(
      duration:
          const Duration(milliseconds: 500), // Customize animation duration
      child: SizedBox(
        height: 250.h,
        width: 348.w,
        child: Stack(
          children: [
            //------------------------------------1
            Positioned(
              top: 45.h,
              left: 0,
              right: 0,
              bottom: 5.h,
              child: FadeInUp(
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Input Field

                          Gaps.vGap30,
                          MyTextFormField(
                              controller: addUserAccountController,
                              hintText: 'addLink'.tr,
                              focusNode: FocusNode(),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                param = AddAccountParams(
                                  id: widget.id,
                                  link: value,
                                );
                                return validateTextFormField(value);
                              }),
                          Gaps.vGap10,
                          // Save Button
                          BlocConsumer<AddUserSocialAccountCubit,
                              AddUserSocialAccountState>(
                            listener: (context, state) {
                              if (state is AddUserSocialAccountSuccess) {
                                Navigator.pop(context);
                              }
                            },
                            builder: (context, state) {
                              //-------------------------params
                               
                              //------------------------------------------------
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FadeInRight(
                                    child: (state
                                            is AddUserSocialAccountLoading)
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : MyDefaultButton(
                                            onPressed: () async {
                                              //-------------------------------param Field
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                await context
                                                    .read<
                                                        AddUserSocialAccountCubit>()
                                                    .addUserSocialAccount(
                                                        param);
                                                //Navigator.pop(context);
                                              }
                                            },
                                            height: 44.h,
                                            width: 128.w,
                                            btnText: "save", // For localization
                                            color: widget.color,
                                            textColor: widget.color ==
                                                    MyColors.socialYellow
                                                ? MyColors.black
                                                : MyColors.white,
                                          ),
                                  ),
                                  if (state is AddUserSocialAccountFailure) ...[
                                    Gaps.vGap10,
                                    Text(
                                      state.errorMessage,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyles.bold14(
                                        color: widget.color ==
                                                    MyColors.socialYellow
                                                ? MyColors.black:widget.color,
                                      ),
                                    ),
                                  ]
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //----------2
            Align(
              alignment: Alignment.topCenter,
              child: FadeInDown(
                child: Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: FadeInLeft(
                      child: DiffImage(
                          width: 50.w, height: 50.h, image: widget.image
                          //userName: 'image',
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? validateTextFormField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a link'; // Error message for empty input
    }

    return null; // Input is valid
  }
}
