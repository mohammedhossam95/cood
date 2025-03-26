import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '/core/utils/values/text_styles.dart';
import '/core/widgets/diff_img.dart';
import '/core/widgets/gaps.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'discover'.tr,
            style: TextStyles.bold32(color: colors.main),
          ),
          Gaps.vGap10,
          Expanded(
            child: MasonryGridView.builder(
              itemCount: 10,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => InkWell(
                onTap: () {},
                child: Stack(
                  children: [
                    DiffImage(
                      height:
                          ((index % 5 == 0 || index % 5 == 3) ? 400.0 : 320.0)
                              .h,
                      image:
                          'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                      fitType: BoxFit.cover,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    Positioned(
                      bottom: 10.h,
                      left: 10.w,
                      right: 10.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Jado Saif',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.bold18(color: Colors.white),
                          ),
                          Gaps.vGap4,
                          Text(
                            'Today',
                            style: TextStyles.regular12(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
