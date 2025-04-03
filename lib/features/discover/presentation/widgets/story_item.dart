import 'package:cood/config/routes/app_routes.dart';
import 'package:cood/core/utils/date_format.dart';
import 'package:cood/core/utils/values/svg_manager.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/diff_img.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/features/discover/domain/entities/stories_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum StoryType { image, video }

class StoryItem extends StatelessWidget {
  final Story item;
  final int index;
  const StoryItem({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (item.mediaType == StoryType.video.name) {
          Navigator.pushNamed(
            context,
            Routes.storyVideoRoute,
            arguments: item,
          );
        } else {
          Navigator.pushNamed(
            context,
            Routes.fullPhotoRoute,
            arguments: item.mediaUrl ?? '',
          );
        }
      },
      child: Stack(
        children: [
          DiffImage(
            height: ((index % 5 == 0 || index % 5 == 3) ? 300.0 : 220.0).h,
            image: item.mediaType == StoryType.image.name
                ? item.mediaUrl ?? ''
                : item.videoThumbnail ?? '',
            fitType: BoxFit.cover,
            borderRadius: BorderRadius.circular(10.r),
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
                  item.user?.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.bold14(color: Colors.white),
                ),
                Gaps.vGap4,
                Text(
                  MyDate().formateDate(item.createdAt ?? DateTime.now()),
                  style: TextStyles.regular14(color: Colors.white),
                ),
              ],
            ),
          ),
          if (item.mediaType == StoryType.video.name)
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                SvgAssets.play,
                height: 24.sp,
                width: 24.sp,
              ),
            )
        ],
      ),
    );
  }
}
