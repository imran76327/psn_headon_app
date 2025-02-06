class SlotListModel {
  final int id;
  final String slotName;
  final int companyId;
  final String companyName;
  final String description;
  final DateTime shiftDate;
  final String startTime;
  final String endTime;
  final int siteId;
  final String worksite;
  final String? nightsift;
  final String? message;
  final String designationId;
  final DateTime? created_at;
  final String? created_by;

  // New fields from SettingModel
  final DateTime notiStartTime;
  final DateTime notiEndTime;
  final int interval;
  final int? noOfNotification;


  SlotListModel({
    required this.companyId,
    required this.companyName,
    required this.id,
    required this.slotName,
    required this.worksite,
    required this.description,
    required this.shiftDate,
    required this.startTime,
    required this.endTime,
    required this.siteId,
    required this.nightsift,
    required this.designationId,
    this.message,
    this.created_at,
    this.created_by,

    // Initialize new fields
    required this.notiStartTime,
    required this.notiEndTime,
    required this.interval,
    required this.noOfNotification,
  });
  // Updated fromJson method to include new fields
  factory SlotListModel.fromJson(Map<String, dynamic> json) {
    return SlotListModel(
      id: json['slot_id'],
      slotName: json['slot_name'].toString(),
      description: json['description'].toString(),
      worksite: json['site_id']['site_name'].toString(),
      companyId: json['company']['company_id'],
      companyName: json['company']['company_name'].toString(),
      shiftDate: DateTime.parse(json['shift_date']),
      startTime: json['start_time'].toString(),
      endTime: json['end_time'].toString(),
      siteId: json['site_id']['site_id'],
      nightsift: json['nightsift'].toString(),
      designationId: json['designation_id'].toString(),
      message: json['message'].toString(),
      created_at: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      created_by: json['created_by'].toString(),
      notiStartTime: DateTime.parse(json['setting_id']['noti_start_time']),
      notiEndTime: DateTime.parse(json['setting_id']['noti_end_time']),
      interval: json['setting_id']['interval'],
      noOfNotification: json['setting_id']['no_of_notification'],
    );
  }

  // Updated toJson method to include new fields
  Map<String, dynamic> toJson() {
    return {
      'slot_name': slotName,
      'description': description,
      'shift_date': shiftDate,
      'start_time': startTime,
      'end_time': endTime,
      'site_id': siteId,
      'nightsift': nightsift,
      'designation_id': designationId,
      'message': message,
      'created_at': created_at?.toIso8601String(),
      'created_by': created_by,
      // Convert new fields to JSON
      'noti_start_time': notiStartTime.toIso8601String(),
      'noti_end_time': notiEndTime.toIso8601String(),
      'interval': interval,
      'no_of_notification': noOfNotification,
    };
  }
}
