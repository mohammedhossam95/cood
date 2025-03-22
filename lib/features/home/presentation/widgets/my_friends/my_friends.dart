import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/widgets/error_text.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/core/widgets/show_dialog.dart';
import 'package:cood/features/categories/presentation/widgets/my_progress.dart';
import 'package:cood/features/home/domain/entities/friend_entity_.dart';
import 'package:cood/features/home/presentation/cubit/get_friends_list/friends_list_cubit.dart';
import 'package:cood/features/home/presentation/cubit/get_friends_list/friends_list_state.dart';
import 'package:cood/features/home/presentation/widgets/my_friends/add_friend_dialog.dart';
import 'package:cood/features/home/presentation/widgets/my_friends/freinds_contact_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySocialFriends extends StatefulWidget {
  const MySocialFriends({super.key});

  @override
  State<MySocialFriends> createState() => _MySocialFriendsState();
}

class _MySocialFriendsState extends State<MySocialFriends> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: MyColors.upBackGround,
                borderRadius: BorderRadius.circular(25.r),
                boxShadow: [
                  BoxShadow(
                    color: MyColors.body.withValues(alpha: .5), // Shadow color
                    spreadRadius: 2.r, // Spread radius
                    blurRadius: 10.r, // Blur radius
                    offset: Offset(0, 3), // Offset in x and y directions
                  ),
                ],
              ),
              child: BlocBuilder<FriendsListCubit, GetFriendsListState>(
                builder: (context, state) {
                  if (state is GetFriendsListLoading) {
                    return const Center(
                      child: MyProgrees(),
                    );
                  }
                  //----------------- this condition should be (state is CategoriesSuccerss)
                  if (state is GetFriendsListSuccerss) {
                    List<FriendEntity> friendsList =
                        state.response.data as List<FriendEntity>;
                    return (friendsList.isNotEmpty)
                        ? ListView.builder(
                            itemBuilder: (context, index) => FriendsContactCard(
                              contacts: friendsList[index],
                              isPhoneAppear: true,
                            ),
                            itemCount: friendsList.length,
                          )
                        : Center(
                            child: ErrorText(
                            width: ScreenUtil().screenWidth,
                            text: 'noData'.tr,
                          ));
                  } else if (state is GetFriendsListFailure) {
                    return ErrorText(
                      text: state.errorMessage,
                      width: ScreenUtil().screenWidth,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
          Gaps.vGap20,
          //-----------------4
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 207.0.h,
                margin: EdgeInsets.all(10.h),
                child: MyDefaultButton(
                  onPressed: () {
                    showAppDialog(
                      context: context,
                      child: AddFriendDialog(),
                    );
                  },
                  height: 50.h,
                  btnText: "addFriend",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
