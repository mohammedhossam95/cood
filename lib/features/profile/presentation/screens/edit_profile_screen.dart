import 'dart:io';

import 'package:cood/config/routes/app_routes.dart';
import 'package:cood/core/params/auth_params.dart';
import 'package:cood/core/utils/constants.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/features/auth/domain/entities/login_response.dart';
import 'package:cood/features/auth/presentation/widgets/custom_back_icon.dart';
import 'package:cood/features/profile/presentation/cubit/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/tags_text_form_field.dart';
import '/injection_container.dart';
import '../../../../core/widgets/profile_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController usernameController = TextEditingController();
  final FocusNode usernameFocus = FocusNode();

  File? profileImage;

  late User user;

  @override
  void initState() {
    user = sharedPreferences.getUser() ?? User();
    usernameController.text = user.name ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.backGround,
        appBar: AppBar(
          backgroundColor: colors.backGround,
          title: Text(
            'editMyProfile'.tr,
            style: TextStyles.bold20(color: colors.main),
          ),
          elevation: 0,
          leading: CustomBack(),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap78,
                Center(
                  child: ProfileImage(
                    image: user.image ?? '',
                    updateBannerImage: (f) {
                      setState(() {
                        profileImage = f;
                      });
                    },
                  ),
                ),
                Gaps.vGap45,
                Text(
                  'name'.tr,
                  style: TextStyles.bold14(color: colors.main),
                ),
                Gaps.vGap10,
                AppTextFormField(
                  controller: usernameController,
                  focusNode: usernameFocus,
                  hintText: 'name'.tr,
                  borderColor: colors.main,
                ),
                Gaps.vGap30,
                Gaps.vGap50,
                BlocConsumer<EditProfileCubit, EditProfileState>(
                  listener: (context, state) {
                    if (state is EditProfileLoaded) {
                      User updated = state.response.data as User;
                      Navigator.of(context).pop(true);
                      sharedPreferences.saveUser(updated);
                    } else if (state is EditProfileError) {
                      Constants.showSnakToast(
                          context: context, message: state.msg, type: 3);
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60.w),
                          child: (state is EditProfileIsLoading)
                              ? const Center(child: CircularProgressIndicator())
                              : MyDefaultButton(
                                  onPressed: () {
                                    BlocProvider.of<EditProfileCubit>(context)
                                        .editProfile(AuthParams(
                                      name: usernameController.text,
                                      image: profileImage,
                                    ));
                                  },
                                  btnText: 'saveChanges',
                                  borderColor: colors.main,
                                  color: colors.main,
                                  textStyle: TextStyles.bold17(),
                                ),
                        ),
                        if (state is EditProfileError) ...[
                          Gaps.vGap10,
                          Text(
                            state.msg,
                            style: TextStyles.bold14(color: colors.errorColor),
                          ),
                        ],
                      ],
                    );
                  },
                ),
                Gaps.vGap30,
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.changePasswordRoute);
                  },
                  child: SizedBox(
                    width: ScreenUtil().screenWidth,
                    child: Text(
                      'changePassword',
                      textAlign: TextAlign.center,
                      style: TextStyles.underlineRegular20(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
