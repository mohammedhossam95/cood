import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/app_strings.dart';
import '/core/widgets/error_text.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/geust_widget.dart';
import '/features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '/features/reservations/domain/entity/reservation_entity.dart';
import '/features/reservations/presentation/cubit/reservation_cubit/reservation_state.dart';
import '/features/reservations/presentation/widgets/my_progress.dart';
import '/features/reservations/presentation/widgets/no_reservations_widget.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/my_default_button.dart';
import '../../../../injection_container.dart';
import '../cubit/reservation_cubit/reservation_cubit.dart';
import '../widgets/reservation_container.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  UserType? userType;
  @override
  void initState() {
    context.read<ReservationCubit>().getReservations();
    userType = BlocProvider.of<AutoLoginCubit>(context).userType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: userType == UserType.approved
          ? BlocBuilder<ReservationCubit, ReservationState>(
              builder: (context, state) {
                if (state is ReservationLoading) {
                  return const Center(
                    child: MyProgrees(),
                  );
                } else if (state is ReservationSuccerss) {
                  List<GetReservation> reservation =
                      state.response.data as List<GetReservation>;
                  return reservation.isEmpty
                      ? const NoReservations()
                      : ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: reservation.length,
                          separatorBuilder: (context, index) => Gaps.vGap10,
                          itemBuilder: (context, index) => ReservationContainer(
                            getReservation: reservation[index],
                          ),
                        );
                } else if (state is ReservationFailure) {
                  if (state.errorMessage == AppStrings.unAuthorizedFailure) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'confirem_login'.tr,
                            style: TextStyles.bold20(),
                          ),
                          Gaps.vGap15,
                          MyDefaultButton(
                            width: ScreenUtil.defaultSize.width,
                            color: colors.main,
                            btnText: 'login',
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(
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
                      width: ScreenUtil().screenWidth * 0.3,
                    );
                  }
                } else {
                  return const SizedBox();
                }
              },
            )
          : const GuestWidget(),
    );
  }
}
