import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/widgets/app_divider.dart';
import 'package:cood/core/widgets/app_snack_bar.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/core/widgets/show_confirmation_alert.dart';
import 'package:cood/core/widgets/show_dialog.dart';
import 'package:cood/features/categories/domain/entity/category_entity.dart';
import 'package:cood/features/categories/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:cood/features/categories/presentation/cubit/post_selected_category_cubit/post_selected_category_cubit.dart';
import 'package:cood/features/categories/presentation/cubit/post_selected_category_cubit/post_selected_category_state.dart';
import 'package:cood/features/categories/presentation/widgets/communication_guide_item.dart';
import 'package:cood/features/categories/presentation/widgets/my_progress.dart';
import 'package:cood/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

addCommunicationChannelButton(BuildContext context) => showAppDialog(
      borderRadius: 30.0.r,
      horizontalPadding: 0.0,
      verticalPadding: 0.0,
      context: context,
      child: Container(
        height: 590.0.h,
        width: 393.0.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: MyColors.lightBlue,
        ),
        child: ShowCommunicationChannelDialog(),
      ),
    );

class ShowCommunicationChannelDialog extends StatelessWidget {
  const ShowCommunicationChannelDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostSelectedCategoryCubit, PostSelectedCategoryState>(
      listener: (context, state) {
        if (state is PostSelectedCategorySuccerss) {
          Navigator.pop(context);
          showAppSnackBar(
            context: context,
            message: state.response.message ?? '',
            type: ToastType.success,
          );
        }
        if (state is PostSelectedCategoryFailure) {
          showAppSnackBar(
            context: context,
            message: state.errorMessage,
            type: ToastType.error,
          );
        }
      },
      child: Column(
        children: [
          Gaps.vGap20,
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: AppDivider(
              color: colors.main,
              height: 2.h,
              width: 50.w,
            ),
          ),
          Gaps.vGap10,
          Text(
            'communication_channels'.tr,
            style: TextStyle(
              color: colors.main,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gaps.vGap10,
          AppDivider(
            color: colors.main,
            height: 2.h,
            width: 250.w,
          ),
          Gaps.vGap20,
          Expanded(
            child: BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesLoading) {
                  return const Center(child: MyProgrees());
                } else if (state is CategoriesSuccerss) {
                  List<CategoryEntity> allCommunicationCategory =
                      state.response.data as List<CategoryEntity>;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: allCommunicationCategory.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showConfirmatioAlert(context,
                              nameAr: allCommunicationCategory[index].nameAr,
                              nameEn: allCommunicationCategory[index].nameEn,
                              isArabic: AppLocalizations.of(context)!.isArLocale,
                              confirmYes: () async {
                            await context
                                .read<PostSelectedCategoryCubit>()
                                .postSelectedCategory(
                              [allCommunicationCategory[index].id ?? -1],
                            );
                          }, confirmNo: () {
                            Navigator.pop(context);
                          });
                        },
                        child: CommunicationGuideItem(
                          item: allCommunicationCategory[index],
                          isAddButton: true,
                        ),
                      );
                    },
                  );
                } else if (state is CategoriesFailure) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          Gaps.vGap20,
          MyDefaultButton(
            onPressed: () {
              Navigator.pop(context);
            },
            height: 44.h,
            width: 128.w,
            btnText: "save",
          ),
          Gaps.vGap20,
        ],
      ),
    );
  }
}
