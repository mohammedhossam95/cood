import 'package:bloc/bloc.dart';

import '../../../data/model/reservation_data.dart';
import 'reservation_state.dart';

class ReservationDataCubit extends Cubit<ReservationState> {
  ReservationDataCubit() : super(ReservationInitial());

  String? fromBranch;
  String? toBranch;
  String? startTime;
  String? endTime;
  String? startDate;
  String? endDate;
  String planType = 'Daily';
  String? coupon;

  saveReservationData() async {
    // sharedPreferences.saveReservasionData(
    //   ReservasionData(
    //     planType: planType,
    //     fromBranch: fromBranch!,
    //     startTime: startTime!,
    //     endTime: endTime!,
    //     startDate: startDate!,
    //     endDate: endDate,
    //     toBranch: toBranch,
    //     promocodeName: coupon,
    //   ),
    // );
  }

  removeReservationData() {
    // sharedPreferences.removeReservasionData();
    fromBranch = null;
    toBranch = null;
    startTime = null;
    endTime = null;
    startDate = null;
    endDate = null;
    coupon = null;
  }

  ReservasionData getReservationData() {
    // return sharedPreferences.getReservasionData();
    return ReservasionData(
      planType: planType,
      fromBranch: fromBranch!,
      startTime: startTime!,
      endTime: endTime!,
      startDate: startDate!,
      endDate: endDate,
      toBranch: toBranch,
      promocodeName: coupon,
    );
  }

  bool checkData() {
    if (fromBranch == null ||
        startDate == null ||
        startTime == null ||
        endTime == null) {
      return false;
    } else {
      return true;
    }
  }
}
