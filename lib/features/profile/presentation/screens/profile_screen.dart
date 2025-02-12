import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/utils/constants.dart';
import '/core/utils/enums.dart';
import '/core/utils/values/svg_manager.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/geust_widget.dart';
import '/core/widgets/tags_text_form_field.dart';
import '/features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '/features/profile/domain/entities/user_entity.dart';
import '/features/profile/presentation/cubit/get_user_cubit/get_user_cubit.dart';
import '/injection_container.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final FocusNode phoneNumberFocus = FocusNode();
  final TextEditingController usernameController = TextEditingController();
  final FocusNode usernameFocus = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final TextEditingController passportController = TextEditingController();
  final FocusNode passportFocus = FocusNode();

  File? passportImage;
  File? licenseImage;

  UserType? userType;
  @override
  void initState() {
    BlocProvider.of<GetUserCubit>(context).getUSer();
    userType = BlocProvider.of<AutoLoginCubit>(context).userType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userType == UserType.approved
          ? AppBar(
              leading: BackButton(color: colors.main),
              centerTitle: true,
              title: SvgPicture.asset(SvgAssets.profile),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.editProfileScreenRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'edit'.tr,
                      style: TextStyles.regular14(color: colors.main),
                    ),
                  ),
                ),
              ],
            )
          : null,
      body: userType == UserType.approved
          ? BlocConsumer<GetUserCubit, GetUserState>(
              listener: (context, state) {
                if (state is GetUserSuccess) {
                  UserDetailsEntity userDetailsEntity =
                      state.response.data as UserDetailsEntity;
                  phoneNumberController.text =
                      userDetailsEntity.phoneNumber ?? '';
                  usernameController.text = userDetailsEntity.username ?? '';
                  emailController.text = userDetailsEntity.email ?? '';
                  passportController.text =
                      userDetailsEntity.identificationPath ?? '';
                  // licenseController.text = userDetailsEntity.licencePath ?? '';
                  // passportImage = File(userDetailsEntity.identificationPath ?? '');
                  // licenseImage = File(userDetailsEntity.licencePath ?? '');
                }
              },
              builder: (context, state) {
                if (state is GetUserLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetUserSuccess) {
                  return Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'mobile_number'.tr,
                          style: TextStyles.semiBold14(color: colors.main),
                        ),
                        Gaps.vGap10,
                        AppTextFormField(
                            controller: phoneNumberController,
                            focusNode: phoneNumberFocus,
                            readOnly: true,
                            hintColor: colors.main,
                            hintText: 'xxxxxxxxxx'),
                        Gaps.vGap12,
                        Text(
                          'username'.tr,
                          style: TextStyles.semiBold14(color: colors.main),
                        ),
                        Gaps.vGap10,
                        AppTextFormField(
                            readOnly: true,
                            controller: usernameController,
                            focusNode: usernameFocus,
                            hintColor: colors.main,
                            hintText: 'xxxxxxxxxx'),
                        Gaps.vGap12,
                        Text(
                          'email'.tr,
                          style: TextStyles.semiBold14(color: colors.main),
                        ),
                        Gaps.vGap10,
                        AppTextFormField(
                            readOnly: true,
                            controller: emailController,
                            focusNode: emailFocus,
                            hintColor: colors.main,
                            hintText: 'xxxxxxxxxx'),
                        Gaps.vGap12,
                        /*
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                                color: colors.dividerColor, width: 1.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'passport_or_id_photo'.tr,
                                style:
                                    TextStyles.semiBold14(color: colors.main),
                              ),
                              Gaps.vGap10,
                              ImagePickerWidget(
                                updateBannerImage: (image) {
                                  setState(() {
                                    passportImage = image;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        Gaps.vGap12,
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                                color: colors.dividerColor, width: 1.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'driver_license_photo'.tr,
                                style:
                                    TextStyles.semiBold14(color: colors.main),
                              ),
                              Gaps.vGap10,
                              ImagePickerWidget(
                                updateBannerImage: (image) {
                                  setState(() {
                                    licenseImage = image;
                                  });
                                },
                              )
                            ],
                          ),
                        )
                      */
                      ],
                    ),
                  );
                } else if (state is GetUserError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          : const GuestWidget(),
      bottomSheet: userType == UserType.approved
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Constants.showLoading(context);
                      Future.delayed(
                        const Duration(seconds: 2),
                        () {
                          if (context.mounted) {
                            Constants.hideLoading(context);
                            BlocProvider.of<AutoLoginCubit>(context)
                                .saveUserCycle(type: UserCycle.login);
                            BlocProvider.of<AutoLoginCubit>(context)
                                .saveUserType(type: UserType.pending);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.loginScreenRoute,
                              (route) => false,
                            );
                          }
                        },
                      );
                    },
                    child: Text('delete_account'.tr,
                        style: TextStyles.semiBold14(color: colors.secondary)),
                  ),
                  InkWell(
                    onTap: () {
                      Constants.showLoading(context);
                      Future.delayed(
                        const Duration(seconds: 2),
                        () {
                          if (context.mounted) {
                            Constants.hideLoading(context);
                            BlocProvider.of<AutoLoginCubit>(context)
                                .saveUserCycle(type: UserCycle.login);
                            BlocProvider.of<AutoLoginCubit>(context)
                                .saveUserType(type: UserType.pending);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.loginScreenRoute,
                              (route) => false,
                            );
                          }
                        },
                      );
                    },
                    child: Text('logout'.tr,
                        style: TextStyles.semiBold14(color: colors.secondary)),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
