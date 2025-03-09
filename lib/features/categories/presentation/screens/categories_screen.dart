import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/widgets/defult_text_field.dart';
import 'package:cood/features/categories/domain/entity/category_entity.dart';
import 'package:cood/features/categories/presentation/cubit/categories_cubit/categories_state.dart';
import 'package:cood/features/categories/presentation/widgets/communication_guide_item.dart';
import 'package:cood/features/categories/presentation/widgets/my_progress.dart';
import 'package:cood/features/categories/presentation/widgets/no_reservations_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/app_strings.dart';
import '/core/widgets/error_text.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/geust_widget.dart';
import '/features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/my_default_button.dart';
import '../../../../injection_container.dart';
import '../cubit/categories_cubit/categories_cubit.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  UserType? userType;
  @override
  void initState() {
    context.read<CategoriesCubit>().getCategoriess();
    userType = BlocProvider.of<AutoLoginCubit>(context).userType;
    super.initState();
  }

//-----------------------------------this for test----
  bool isUserApproaved = true;
  final TextEditingController searchController = TextEditingController();
  // List<ComuniGuideItemEntity> communicationList = [
  //   ComuniGuideItemEntity(
  //     'اجتماعي',
  //     'assets/images/Users.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     'الطعم والشراب',
  //     'assets/images/Food Bar.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     'الصور الفوتوغرافيه',
  //     'assets/images/Picture.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     'الرياضه',
  //     'assets/images/Weightlifting.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     'السفر والسياحه',
  //     'assets/images/World Map.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     'السيارات',
  //     'assets/images/Car.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     'الأخبار والمجلات',
  //     'assets/images/Newspaper.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     'الالعاب',
  //     'assets/images/PS Controller.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     'البيع والشراء',
  //     'assets/images/Sell Stock.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     'الصحه والقلب',
  //     'assets/images/Caduceus.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     'الترفيه',
  //     'assets/images/Retro TV.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     'الفن والموسيقي',
  //     'assets/images/Music.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     'الشعر والكتب',
  //     'assets/images/Open Book.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     ' ريادة الاعمال',
  //     'assets/images/Business.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     '  تصاميم الجرافيك',
  //     'assets/images/Photo Editor.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     '  الاهل والطفال',
  //     'assets/images/Full Family.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     '  التعليم',
  //     'assets/images/Mortarboard.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     '  الحيوانات',
  //     'assets/images/Elephant.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     '  العقارات',
  //     'assets/images/Building.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     ' الأفلام والمسلسلات ',
  //     'assets/images/Film Reel.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     ' التقنية',
  //     'assets/images/Electronics.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     'المواهب',
  //     'assets/images/Innovation.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     ' الصيانة والصناعة ',
  //     'assets/images/Services.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     ' القصص ',
  //     'assets/images/Unicorn.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     ' الهدايا والأزهار',
  //     'assets/images/Gift.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     ' اللغات ',
  //     'assets/images/Language.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     ' الموضه والجمال ',
  //     'assets/images/Arab.png',
  //   ),
  //   ComuniGuideItemEntity(
  //     'كوميدي  ',
  //     'assets/images/Comedy.png',
  //   ),
  // ];
//------------------------------

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        //----------------- this condition should be (userType == UserType.approved)
        child: (userType == UserType.user)
            ? BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return const Center(
                      child: MyProgrees(),
                    );
                    //----------------- this condition should be (state is CategoriesSuccerss)
                  } else if (state is CategoriesSuccerss) {
                    //List<CategoryEntity> communicationList = [];
                    List<CategoryEntity> communicationList =
                        state.response.data as List<CategoryEntity>;
                    return communicationList.isEmpty
                        ? const NoCategoriess()
                        : Padding(
                            padding: EdgeInsets.all(10.0.w),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'reservations'.tr,
                                      style:
                                          TextStyles.bold32(color: colors.main),
                                    ),
                                  ],
                                ),
                                Gaps.vGap20,
                                MyTextFormField(
                                  controller: searchController,
                                  focusNode: FocusNode(),
                                  hintText: "search".tr,
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.search,
                                      color: MyColors.main,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20.h),
                                    decoration: BoxDecoration(
                                      color: MyColors.white,
                                      borderRadius: BorderRadius.circular(25.r),
                                    ),
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: communicationList.length,
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              Routes.communicationItemDetails);
                                        },
                                        child: CommunicationGuideItem(
                                            item: communicationList[index]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                  } else if (state is CategoriesFailure) {
                    if (state.errorMessage == AppStrings.unAuthorizedFailure) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'confirem_login'.tr,
                              style: TextStyles.bold20(),
                            ),
                            Gaps.vGap15,
                            MyDefaultButton(
                              width: ScreenUtil.defaultSize.width,
                              color: colors.main,
                              btnText: 'login',
                              onPressed: () =>
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      Routes.loginScreenRoute,
                                      (route) => false),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ErrorText(
                        text: state.errorMessage,
                        width: ScreenUtil().screenWidth * 0.3,
                      );
                    }
                  } else {
                    return const SizedBox();
                  }
                },
              )
            : const GuestWidget(),
      ),
    );
  }
}
