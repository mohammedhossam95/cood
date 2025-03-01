
import 'package:cood/features/home/presentation/widgets/myAccounts/my_accounts.dart';

import 'package:cood/features/home/presentation/widgets/myPhotos/my_photos.dart';
import 'package:cood/features/home/presentation/widgets/my_friends/my_friends.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/params/car_params.dart';
import '/core/utils/log_utils.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/features/home/domain/entities/plans_status_entity.dart';
import '/features/home/presentation/cubit/get_plans_status_cubit/get_plans_status_cubit.dart';
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

  @override
  void initState() {
    BlocProvider.of<GetPlansStatusCubit>(context).getPlansStatus();
    // BlocProvider.of<GetCitiesCubit>(context).getCities();
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
                    Center(
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: colors.main,
                          border: Border.all(
                            color: colors.main,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.asset(
                            "assets/images/user.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Gaps.hGap10,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'فهد سليمان',
                            style: TextStyles.bold14(color: colors.main),
                          ),
                          Text(
                            '359698845',
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
                        Navigator.pushNamed(context, Routes.settingScreenRoute);
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
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.vGap8,
                    BlocBuilder<GetPlansStatusCubit, GetPlansStatusState>(
                      builder: (context, state) {
                        if (state is GetPlansStatusLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is GetPlansStatusSuccess) {
                          PlansStatusEntity plansStatus =
                              state.response.data as PlansStatusEntity;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              plansStatus.daily!
                                  ? _buildDurationOption('myAccounts', 0)
                                  : const SizedBox.shrink(),
                              Gaps.hGap10,
                              plansStatus.weekly!
                                  ? _buildDurationOption('myPhotos', 1)
                                  : const SizedBox.shrink(),
                              Gaps.hGap10,
                              plansStatus.monthly!
                                  ? _buildDurationOption('myFriends', 2)
                                  : const SizedBox.shrink(),
                            ],
                          );
                        } else if (state is GetPlansStatusError) {
                          return Center(child: Text(state.message));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    Gaps.vGap8,
                  ],
                ),
              ),
              //--------3
              //ToDo---------------------------- here switch index(frinds, photoes or accounts)
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
        return MySocialAccounts();
      case 1:
        return MySocialPhotos();
      case 2:
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
          padding: EdgeInsets.symmetric(vertical: 15.h),
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
