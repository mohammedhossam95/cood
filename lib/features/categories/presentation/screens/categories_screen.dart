import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/widgets/defult_text_field.dart';
import 'package:cood/features/categories/domain/entity/category_entity.dart';
import 'package:cood/features/categories/presentation/cubit/get_filter_user_by_category/get_filter_user_by_category_cubit.dart';
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
  bool isUserApproaved = true;
  final TextEditingController searchController = TextEditingController();
  List<CategoryEntity> communicationList = [];
  List<CategoryEntity> filteredCommunicationList = [];
  @override
  void initState() {
    context.read<CategoriesCubit>().getCategoriess();
    userType = BlocProvider.of<AutoLoginCubit>(context).userType;
    super.initState();
  }

  void _filterCategories(String query,BuildContext context) {
    setState(() {
      if (query.isEmpty) {
        filteredCommunicationList = List.from(communicationList);
      } else {
        filteredCommunicationList = communicationList.where((category) {
          final title = (AppLocalizations.of(context)!.isArLocale)?category.nameAr?.toLowerCase()??'':category.nameEn?.toLowerCase() ?? '';
          return title.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: (userType == UserType.approved)
            ? BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return const Center(
                      child: MyProgrees(),
                    );
                  } else if (state is CategoriesSuccerss) {
                    communicationList =
                        state.response.data as List<CategoryEntity>;
                    if (filteredCommunicationList.isEmpty) {
                      filteredCommunicationList = List.from(communicationList);
                    }

                    return filteredCommunicationList.isEmpty
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
                                    onPressed: () {
                                      _filterCategories(searchController.text,context);
                                    },
                                    icon: Icon(
                                      Icons.search,
                                      color: MyColors.main,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    _filterCategories(value??'',context);
                                  },
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
                                      itemCount:
                                          filteredCommunicationList.length,
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                        onTap: () async {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.communicationItemSliver,
                                          );
                                          await context
                                              .read<
                                                  GetFilterUserByCategoryCubit>()
                                              .getGetFilterUserByCategoryId(
                                                  filteredCommunicationList[
                                                              index]
                                                          .id ??
                                                      2);
                                        },
                                        child: CommunicationGuideItem(
                                            item: filteredCommunicationList[
                                                index]),
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
                              'back_to_login'.tr,
                              style: TextStyles.bold20(),
                            ),
                            Gaps.vGap16,
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
                        width: ScreenUtil().screenWidth,
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
