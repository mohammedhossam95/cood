import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/utils/constants.dart';
import '/core/utils/enums.dart';
import '/core/utils/values/assets.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/loading_view.dart';
import '/core/widgets/my_default_button.dart';
import '/core/widgets/profile_image.dart';
import '/core/widgets/tags_text_form_field.dart';
import '/features/auth/data/models/new_models/auth_model.dart';
import '/features/auth/domain/usecases/new_usecases/new_login_usecase.dart';
import '/features/auth/domain/usecases/new_usecases/register_usecase.dart';
import '/features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '/features/auth/presentation/cubit/new_cubit/new_login/new_login_cubit.dart';
import '/features/auth/presentation/cubit/new_cubit/register/register_cubit.dart';
import '/injection_container.dart';
import '../../../../../core/utils/validator.dart';

class NewUserRegisterScreen extends StatefulWidget {
  final AuthParam authParam;

  const NewUserRegisterScreen({super.key, required this.authParam});

  @override
  State<NewUserRegisterScreen> createState() => _NewUserRegisterScreenState();
}

class _NewUserRegisterScreenState extends State<NewUserRegisterScreen> {
  final GlobalKey<FormState> formState = GlobalKey();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode userNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocus = FocusNode();

  File? passportFile;
  File? licenceFile;

  // final ImagePicker _picker = ImagePicker();
  File? avatarImageFile;
  Country selcCountry = Country(
    phoneCode: '20',
    countryCode: 'EG',
    e164Sc: 0,
    geographic: true,
    level: -1,
    name: 'Egypt',
    example: '1001234567',
    displayName: 'Egypt (EG) [+20]',
    displayNameNoCountryCode: 'Egypt (EG)',
    e164Key: '20-EG-0',
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 8,
          backgroundColor: colors.main,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.arrow_back,
                color: colors.upBackGround,
              ),
              InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, Routes.newUserRegisterRoute);
                },
                child: Text(
                  '',
                  style: TextStyles.bold12(color: colors.upBackGround),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: colors.upBackGround,
        body: BlocConsumer<NewLoginCubit, NewLoginState>(
          listener: (context, state) {
            if (state is NewLoginSuccessState) {
              // Navigator.pushNamed(
              //   context,
              //   Routes.homePageRoute,
              //   // arguments: state.resp.data?.phone ?? '',
              // );
              // loader = false;

              BlocProvider.of<AutoLoginCubit>(context)
                  .saveUserCycle(type: UserCycle.auth);
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.mainPageRoute,
                (Route route) => false,
              );

              // Navigator.pushNamed(
              //   context,
              //   Routes.homePageRoute,
              //   arguments: state.resp.data?.phone ?? '',
              // );
            }
            if (state is NewLoginErrorState) {
              // loader = false;

              Constants.showSnakToast(
                context: context,
                type: 3,
                message: state.errorMessage,
              );

              // Navigator.pushNamed(context,
              //     Routes.otpAuthRoute);
            }
          },
          builder: (context, state) {
            return Form(
              key: formState,
              child: Column(
                children: [
                  // CustomAppBar(
                  //   txt: 'new_register'.tr,
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(20.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gaps.vGap16,

                            Text(
                              'enterUserData'.tr,
                              style: TextStyles.medium17(color: colors.main),
                              textAlign: TextAlign.right,
                            ),

                            // ProfileImage(
                            //   updateBannerImage: (img) {
                            //     setState(() {
                            //       avatarFile = img;
                            //     });
                            //   },
                            // ),
                            Gaps.vGap25,

                            AppTextFormField(
                              controller: userNameController,
                              focusNode: userNameFocus,
                              hintText: 'new_user_name'.tr,
                              textInputAction: TextInputAction.next,
                              validatorType: ValidatorType.name,
                            ),
                            Gaps.vGap25,
                            AppTextFormField(
                              controller: emailController,
                              focusNode: emailFocus,
                              hintText: 'new_email_address'.tr,
                              textInputAction: TextInputAction.next,
                              validatorType: ValidatorType.email,
                            ),
                            Gaps.vGap25,
                            AppTextFormField(
                              controller: passwordController,
                              focusNode: passwordFocus,
                              hintText: 'password'.tr,
                              textInputAction: TextInputAction.next,
                              validatorType: ValidatorType.password,
                            ),
                            Gaps.vGap25,

                            InkWell(
                              onTap: () {
                                // onPickImage()
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 18.h),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: colors.dividerColor,
                                    width: 1.0,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.r)),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'attachPassport'.tr,
                                          style: TextStyles.medium12(
                                              color: Colors.grey),
                                        ),
                                        Image.asset(
                                          ImgAssets.uploadImage,
                                          width: 24.w,
                                          height: 24.h,
                                        )
                                      ],
                                    ),
                                    Gaps.vGap4,
                                    Container(
                                      height: 110.h,
                                      // color: Color(0xffD9D9D9),
                                      decoration: BoxDecoration(
                                        color: colors.dividerColor,
                                        border: Border.all(
                                          color: colors.dividerColor,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.r)),
                                      ),
                                      child: ProfileImage(
                                        updateBannerImage: (img) {
                                          setState(() {
                                            passportFile = img;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            Gaps.vGap25,

                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 18.h),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: colors.dividerColor,
                                  width: 1.0,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r)),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'attachLicence'.tr,
                                        style: TextStyles.medium12(
                                            color: Colors.grey),
                                      ),
                                      Image.asset(
                                        ImgAssets.uploadImage,
                                        width: 24.w,
                                        height: 24.h,
                                      )
                                    ],
                                  ),
                                  Gaps.vGap4,
                                  Container(
                                    height: 110.h,
                                    // color: Color(0xffD9D9D9),
                                    decoration: BoxDecoration(
                                      color: colors.dividerColor,
                                      border: Border.all(
                                        color: colors.dividerColor,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.r)),
                                    ),
                                    child: ProfileImage(
                                      updateBannerImage: (img) {
                                        setState(() {
                                          licenceFile = img;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                            // Text(
                            //   'phone'.tr,
                            //   style: TextStyles.bold16(),
                            // ),
                            // Gaps.vGap15,
                            // Row(
                            //   children: [
                            //     CountryCodeWidget(
                            //       country: selcCountry,
                            //       updateValue: (Country value) {},
                            //     ),
                            //     Gaps.hGap4,
                            //     Expanded(
                            //       child: AppTextFormField(
                            //         controller: phoneController,
                            //         focusNode: phoneFocus,
                            //         keyboardType: TextInputType.phone,
                            //         textInputAction: TextInputAction.done,
                            //         isPhone: false,
                            //         validatorType: ValidatorType.phone,
                            //         hintText: 'phone_number'.tr,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Gaps.vGap25,
                            // Text(
                            //   'select_location'.tr,
                            //   style: TextStyles.bold16(),
                            // ),
                            // Gaps.vGap15,
                            // InkWell(
                            //   onTap: () => getPermission(),
                            //   child: AppTextFormField(
                            //     onTap: () => getPermission(),
                            //     controller: locationController,
                            //     focusNode: locationFocus,
                            //     hintText: 'location'.tr,
                            //     readOnly: true,
                            //     textInputAction: TextInputAction.done,
                            //     suffixIcon: IconButton(
                            //       icon: Icon(
                            //         Icons.location_on_outlined,
                            //         color: colors.main,
                            //       ),
                            //       onPressed: () {},
                            //     ),
                            //     validatorType: ValidatorType.standard,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: BlocConsumer<RegisterCubit, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterSuccessState) {
                          BlocProvider.of<NewLoginCubit>(context).login(
                            params: NewLoginParams(
                                phoneNumber: widget.authParam.phoneNumber,
                                password: passwordController.text,
                                fcmToken: ""),
                          );
                        }
                        if (state is RegisterErrorState) {
                          state.errorMessage == "هذا الرقم مستخدم من قبل ."
                              ? Constants.showSnakToast(
                                  context: context,
                                  type: 2,
                                  message: state.errorMessage,
                                )
                              : Constants.showSnakToast(
                                  context: context,
                                  type: 3,
                                  message: state.errorMessage,
                                );
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            (state is RegisterLoadingState)
                                ? const LoadingView()
                                : MyDefaultButton(
                                    btnText: 'continue',
                                    color: colors.secondary,
                                    borderColor: colors.secondary,
                                    textColor: colors.upBackGround,
                                    onPressed: () async {
                                      if (formState.currentState!.validate()) {
                                        formState.currentState!.save();
                                        try {
                                          if (passportFile != null) {
                                            if (licenceFile != null) {
                                              BlocProvider.of<RegisterCubit>(
                                                      context)
                                                  .register(
                                                params: RegisterParams(
                                                    username:
                                                        userNameController.text,
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                    userCode: widget
                                                        .authParam.customerCode,
                                                    drivingLicence: licenceFile,
                                                    identification:
                                                        passportFile),
                                              );
                                            } else {
                                              Future.delayed(Duration.zero, () {
                                                if (!context.mounted) return;
                                                Constants.showSnakToast(
                                                  type: 2,
                                                  context: context,
                                                  message:
                                                      'pickLicencePhoto'.tr,
                                                );
                                              });
                                            }
                                          } else {
                                            Future.delayed(Duration.zero, () {
                                              if (!context.mounted) return;
                                              Constants.showSnakToast(
                                                type: 2,
                                                context: context,
                                                message: 'pickPassportPhoto'.tr,
                                              );
                                            });
                                          }
                                        } on PlatformException catch (e) {
                                          debugPrint(e.toString());

                                          Future.delayed(Duration.zero, () {
                                            if (!context.mounted) return;
                                            Constants.showSnakToast(
                                              type: 2,
                                              context: context,
                                              message: 'error_valid_name'.tr,
                                            );
                                          });
                                        }
                                      }
                                    },
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().screenHeight * .03,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  unFocus() {
    userNameFocus.unfocus();
    emailFocus.unfocus();
    passwordFocus.unfocus();
    // phoneFocus.unfocus();
  }
}

class AmrTheFristMessageRegisterWidget extends StatelessWidget {
  final String itemTitel;
  final String itemSubTitel;

  const AmrTheFristMessageRegisterWidget({
    super.key,
    required this.itemTitel,
    required this.itemSubTitel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 63.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.shade100,
      ),
      child: Row(
        children: [
          SvgPicture.asset(ImgAssets.deliveryImage),
          Gaps.hGap16,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemTitel,
                style: TextStyles.regular16(),
              ),
              Text(
                itemSubTitel,
                style: TextStyles.regular14(),
              )
            ],
          )
        ],
      ),
    );
  }
}

class AmrLinearProgressIndecatorWidget extends StatelessWidget {
  final double linearValue;
  final bool isCanceled;
  final String? status;

  const AmrLinearProgressIndecatorWidget({
    super.key,
    required this.linearValue,
    this.isCanceled = false,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(status != null
          ? getColor(status)
          : isCanceled
              ? Colors.red
              : Colors.blue),
      value: linearValue,
      minHeight: 10.h,
      borderRadius: BorderRadius.all(Radius.circular(5.r)),
    );
  }

  Color getColor(status) {
    return status == MyOrderStatus.pending.value
        ? Colors.yellow
        : status == MyOrderStatus.completed.value
            ? Colors.green
            : status == MyOrderStatus.canceled.value ||
                    status == MyOrderStatus.refuseDelegate.value
                ? Colors.red
                : Colors.orangeAccent;
  }
}
