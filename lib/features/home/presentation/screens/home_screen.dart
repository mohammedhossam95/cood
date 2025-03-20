import 'package:cood/core/widgets/diff_img.dart';
import 'package:cood/features/auth/domain/entities/login_response.dart';
import 'package:cood/features/home/presentation/cubit/get_all_user_gallary/get_user_gallary_cubit.dart';
import 'package:cood/features/home/presentation/cubit/get_friends_list/friends_list_cubit.dart';
import 'package:cood/features/home/presentation/cubit/get_user_social_media/get_user_social_media_cubit.dart';
import 'package:cood/features/home/presentation/widgets/myAccounts/my_accounts.dart';
import 'package:cood/features/home/presentation/widgets/myPhotos/my_photos.dart';
import 'package:cood/features/home/presentation/widgets/my_friends/my_friends.dart';
import 'package:cood/features/tabbar/presentation/cubit/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/params/car_params.dart';
import '/core/utils/log_utils.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/features/home/presentation/widgets/cities_list.dart';
import '/injection_container.dart';
import '../../../../config/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedDurationIndex = 0;
  int selectedLocationIndex = 0;
  bool isSelected = false;
  bool isSamePickupLocation = false;
  bool isDriverAgeAbove21 = false;
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  TextEditingController cityController = TextEditingController();
  FocusNode cityFocusNode = FocusNode();
  int? cityId;
  CarParams result = const CarParams();
  CarParams carParams = const CarParams();
  late User user;

  @override
  void initState() {
    // BlocProvider.of<GetCitiesCubit>(context).getCities();
    user = sharedPreferences.getUser() ?? User();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TextTheme theme = Theme.of(context).textTheme;
    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.vGap16,
              //----------1
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    DiffImage(
                      hasBorder: true,
                      width: 60.w,
                      height: 60.w,
                      image: "",
                      padding: const EdgeInsets.all(2.0),
                      userName: user.name ?? "",
                    ),
                    Gaps.hGap10,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name ?? "",
                            style: TextStyles.bold14(color: colors.main),
                          ),
                          Text(
                            user.code ?? "",
                            style: TextStyles.bold14(color: colors.main),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.notificationsScreenRoute);
                      },
                      icon: Icon(
                        Icons.notifications,
                        color: colors.main,
                        size: 36.r,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<BottomNavBarCubit>(context)
                            .changeCurrentScreen(index: 2);
                      },
                      icon: Icon(
                        Icons.settings,
                        color: colors.main,
                        size: 36.r,
                      ),
                    ),
                  ],
                ),
              ),
              //----------2
              Gaps.vGap16,
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDurationOption('myAccounts', 0),
                    Gaps.hGap10,
                    _buildDurationOption('myPhotos', 1),
                    Gaps.hGap10,
                    _buildDurationOption('myFriends', 2),
                  ],
                ),
              ),
                Gaps.vGap16,
              //--------3
              //---- here switch index(frinds, photoes or accounts)
              getCurrentTapBarWidget(selectedDurationIndex),
            ],
          ),
        ],
      ),
    );
  }

  /// Returns the widget corresponding to the given index.
  Widget getCurrentTapBarWidget(int index) {
    // This function is called in _buildDurationOption to assign the appropriate widget based on the index.
    switch (index) {
      case 0:
       context.read<GetUserSocialMediaCubit>().getUserSocialMedia(); 
        return MySocialAccounts();
      case 1:
        context.read<GetUserGallaryCubit>().getAllUserGallary();  
        return MySocialPhotos();
      case 2:
        context.read<FriendsListCubit>().getFriendsList(); 
        return MySocialFriends();
      default:
        // Handle unexpected indices with a default widget.
        return Center(
          child: Text(
            'Invalid Option',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
        );
    }
  }

  _buildDurationOption(String text, int index) {
    final bool isSelected = index == selectedDurationIndex;
    carParams = carParams.copyWith(plan: 'DAILY');
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedDurationIndex = index;
            if (index == 0) {
              carParams = carParams.copyWith(plan: 'myAccounts');
            } else if (index == 1) {
              carParams = carParams.copyWith(plan: 'WEEKLY');
            } else if (index == 2) {
              carParams = carParams.copyWith(plan: 'MONTHLY');
            }
          });
        },
        child: Container(
          alignment: Alignment.center,
          height: 45.h,
          //padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            border: Border.all(color: colors.main, width: 1.5.r),
            color: isSelected ? colors.main : colors.main.withValues(alpha: .4),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Center(
            child: Text(
              text.tr,
              style: TextStyles.bold14(color: colors.baseColor),
            ),
          ),
        ),
      ),
    );
  }

  void showZipCodesSheet() {
    showModalBottomSheet(
        constraints:
            BoxConstraints(maxHeight: ScreenUtil().screenHeight * 0.75),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        context: context,
        builder: (context) => CitiesList(
              updateSelected: (value) {
                if (value != null) {
                  setState(() {
                    carParams = carParams.copyWith(cityId: value.id.toString());
                    carParams = carParams.copyWith(city: value);
                    Log.w(carParams.toString());
                    cityId = value.id;
                    cityController.text = value.nameAr ?? '';
                  });
                } else {
                  setState(() {
                    cityId = null;
                    cityController.clear();
                  });
                }
              },
            ));
  }

  // Widget _buildCheckboxOption(
  //     String text, bool isSelected, Function(bool?) onChanged) {
  //   return Row(
  //     children: [
  //       Checkbox(
  //           value: isSelected,
  //           onChanged: onChanged,
  //           checkColor: Colors.white,
  //           fillColor: WidgetStateProperty.all<Color>(
  //               isSelected ? colors.main : colors.upBackGround)),
  //       Text(
  //         text.tr,
  //         style: TextStyles.regular14(color: colors.main),
  //       ),
  //     ],
  //   );
  // }
}
