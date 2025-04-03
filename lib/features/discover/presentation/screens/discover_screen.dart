import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/widgets/error_text.dart';
import 'package:cood/features/categories/presentation/widgets/my_progress.dart';
import 'package:cood/features/discover/domain/entities/stories_response.dart';
import 'package:cood/features/discover/presentation/cubit/stories_cubit/stories_cubit.dart';
import 'package:cood/features/discover/presentation/widgets/story_item.dart';
import 'package:cood/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
          child: Text(
            'discover'.tr,
            style: TextStyles.bold32(color: colors.main),
          ),
        ),
        Gaps.vGap10,
        Expanded(
          child: BlocBuilder<StoriesCubit, StoriesState>(
            builder: (context, state) {
              if (state is StoriesLoading) {
                return const Center(
                  child: MyProgrees(),
                );
              } else if (state is StoriesSuccess) {
                List<Story> list = state.response.data as List<Story>;

                return list.isNotEmpty
                    ? MasonryGridView.builder(
                        itemCount: list.length,
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => StoryItem(
                          item: list[index],
                          index: index,
                        ),
                      )
                    : Center(
                        child: ErrorText(
                          width: ScreenUtil().screenWidth,
                          text: "noData".tr,
                        ),
                      );
              } else if (state is StoriesFailure) {
                return Center(
                  child: ErrorText(
                    width: ScreenUtil().screenWidth,
                    text: state.errorMessage,
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
