// ignore_for_file: sized_box_for_whitespace

import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/constants.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/utils/values/img_manager.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/diff_img.dart';
import 'package:cood/core/widgets/error_text.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/features/categories/presentation/widgets/my_progress.dart';
import 'package:cood/features/home/domain/entities/pending_request_entity.dart';
import 'package:cood/features/home/presentation/cubit/get_pending_requests/get_pending_request_cubit.dart';
import 'package:cood/features/home/presentation/cubit/get_pending_requests/get_pending_request_state.dart';
import 'package:cood/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendRequestsScreen extends StatelessWidget {
  const FriendRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // bool isArabic = AppLocalizations.of(context)!.isArLocale;
    return SafeArea(
        child: Scaffold(
      backgroundColor: colors.backGround,
      body: Column(
        children: [
          Text(
            'friendRequests'.tr,
            style: TextStyles.bold32(
              color: colors.main,
            ),
          ),
          BlocBuilder<GetPendingRequestCubit, GetPendingRequestState>(
            builder: (context, state) {
              if (state is GetPendingRequestLoading) {
                return Center(
                  child: MyProgrees(),
                );
              } else if (state is GetPendingRequestSuccess) {
                 List<PendingRequestentity> pendRequests=state.response.data as  List<PendingRequestentity>;
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(15.h),
                    height: 80.h,
                    width: 348.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: colors.baseColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 80.h,
                          width: 80.w,
                          child: DiffImage(
                              image: pendRequests[index].sender?.image??nullNetworkImage,
                              borderRadius: BorderRadius.circular(20.r)),
                        ),
                        Gaps.hGap12,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Gaps.vGap5,
                            Text(
                              'friendRequest'.tr,
                              style: TextStyles.semiBold14(
                                color: colors.main,
                              ),
                            ),
                            Gaps.vGap5,
                            Text(
                              pendRequests[index].sender?.name??'',
                              style: TextStyles.semiBold14(),
                            ),
                          ],
                        ),
                        Gaps.hGap40,
                        Row(
                          children: [
                            //------------reject request
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 32.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      ImageAssets.close,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Gaps.hGap20,
                            //------------acceptFriend request
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 32.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: MyColors.socialGreen,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      ImageAssets.accept,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gaps.hGap20,
                      ],
                    ),
                  ),
                  itemCount: pendRequests.length,
                );
              } else if (state is GetPendingRequestFailure) {
                return ErrorText(
                  text: state.errorMessage,
                  width: ScreenUtil().screenWidth,
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    ));
  }
}
