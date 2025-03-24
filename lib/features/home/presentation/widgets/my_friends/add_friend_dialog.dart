// ignore_for_file: avoid_print, sized_box_for_whitespace

import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/constants.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/app_snack_bar.dart';
import 'package:cood/core/widgets/diff_img.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/core/widgets/search_text_field.dart';
import 'package:cood/features/categories/presentation/widgets/my_progress.dart';
import 'package:cood/features/home/domain/entities/search_user_by_code_entity.dart';
import 'package:cood/features/home/presentation/cubit/get_pending_requests/get_pending_request_cubit.dart';
import 'package:cood/features/home/presentation/cubit/get_search_user_by_code/get_search_user_by_code_cubit.dart';
import 'package:cood/features/home/presentation/cubit/get_search_user_by_code/get_search_user_by_code_state.dart';
import 'package:cood/features/home/presentation/cubit/send_friend_request/send_friend_request_cubit.dart';
import 'package:cood/features/home/presentation/cubit/send_friend_request/send_friend_request_state.dart';
import 'package:cood/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddFriendDialog extends StatefulWidget {
  const AddFriendDialog({super.key});

  @override
  State<AddFriendDialog> createState() => _AddFriendDialogState();
}

class _AddFriendDialogState extends State<AddFriendDialog> {
  final TextEditingController addFriendController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isArabic = AppLocalizations.of(context)!.isArLocale;
    String sendFriendRequestError = '';
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'addFriend'.tr,
              style: TextStyles.bold24(color: MyColors.main),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 20.0.w,
                right: 20.0.w,
                bottom: 10.0.h,
              ),
              child: Divider(
                color: MyColors.main,
              ),
            ),
            MySearchBar(
              controller: addFriendController,
              hintText: 'searchByCodeNumber'.tr,
              focusNode: FocusNode(),
              onPressed: () {
                context
                    .read<GetSearchUserByCodeCubit>()
                    .getSearchUserByCode(addFriendController.text);
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<GetSearchUserByCodeCubit, GetSearchUserByCodeState>(
              builder: (context, state) {
                if (state is GetSearchUserByCodeLoading) {
                  return Center(
                    child: MyProgrees(),
                  );
                } else if (state is GetSearchUserByCodeSuccess) {
                  SearchUserByCodeEntity searchUserByCodeEntity =
                      state.response.data;
                  return Container(
                    margin: EdgeInsets.all(10.0.h),
                    width: double.infinity,
                    height: 55.0.h,
                    decoration: BoxDecoration(
                        color: MyColors.backGround,
                        borderRadius: BorderRadius.circular(12.0.r),
                        border: Border.all(
                          color: MyColors.black,
                        )),
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // First: Container with Image
                        ClipRRect(
                          child: Container(
                            width: 55.0.w, // Width of the image container
                            height: 55.0.h, // Height of the image container

                            child: DiffImage(
                              image: searchUserByCodeEntity.image ??
                                  nullNetworkImage,
                              borderRadius: isArabic
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(12.0.r),
                                      topRight: Radius.circular(9.0.r),
                                      bottomRight: Radius.circular(9.0.r),
                                    )
                                  : BorderRadius.only(
                                      topLeft: Radius.circular(9.0.r),
                                      topRight: Radius.circular(12.0.r),
                                      bottomLeft: Radius.circular(9.0.r),
                                    ),
                            ),
                          ),
                        ),
                        Gaps.hGap12, // Spacing between image and text

                        Expanded(
                          child: Text(
                            searchUserByCodeEntity.name ?? 'null',
                            style: TextStyles.bold14(),
                            maxLines: 2,
                          ),
                        ),

                        // Third: Button with Text (Add)
                        BlocConsumer<SendFriendRequestCubit,
                            SendFriendRequestState>(
                          listener: (context, state) {
                            if (state is SendFriendRequestSuccess) {
                              showAppSnackBar(
                                context: context,
                                message: state.response.message ?? 'success',
                                type: ToastType.success,
                              );
                              Navigator.pop(context);
                            }
                            if (state is SendFriendRequestFailure) {
                              showAppSnackBar(
                                context: context,
                                message: state.errorMessage,
                                type: ToastType.error,
                              );
                            }
                          },
                          builder: (context, state) {
                            return (state is SendFriendRequestLoading)
                                ? Center(child: CircularProgressIndicator())
                                : MyDefaultButton(
                                    height: 35.0.h,
                                    width: 75.0.w,
                                    btnText: 'add',
                                    borderRadius: 10.0.r,
                                    onPressed: () async {
                                      //--------------send friend request----
                                      await context
                                          .read<SendFriendRequestCubit>()
                                          .sendFriendRequest(
                                              searchUserByCodeEntity.id ?? -1);
                                      
                                    },
                                  );
                          },
                        ),
                        Gaps.hGap8,
                      ],
                    ),
                  );
                } else if (state is GetSearchUserByCodeFailure) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20.0.h),
                    child: Text(
                      state.errorMessage,
                      style: TextStyle(
                        color: colors.main,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(top: 8.0.h),
                    child: Text(
                      'noResult'.tr,
                      style: TextStyle(
                        color: colors.main,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
