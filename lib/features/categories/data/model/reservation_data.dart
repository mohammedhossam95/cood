class ReservasionData {
  String planType;
  String fromBranch;
  String? toBranch;
  String startTime;
  String endTime;
  String startDate;
  String? endDate;
  String? promocodeName;

  ReservasionData({
    required this.fromBranch,
    required this.startTime,
    required this.planType,
    required this.endTime,
    required this.startDate,
    this.endDate,
    this.toBranch,
    this.promocodeName,
  });
}
