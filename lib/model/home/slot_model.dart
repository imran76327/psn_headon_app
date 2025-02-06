
class SlotModel {
  final int id;
  final String slotName;
  final String description;
  final String companyId;
  final DateTime shiftDate;
  final DateTime? attendanceDate;
  final String startTime;
  final String endTime;
  final String siteId;
  final String worksite;
  final String companyName;
  final String attendanceIn;
  final String attendanceOut;
  final String? nightsift;
  final String? message;
  final String designationId;
  final DateTime? created_at;
  final String? created_by;

  SlotModel({
    required this.id,
    required this.slotName,
    required this.worksite,
    required this.companyName,
    required this.description,
    required this.companyId,
    required this.shiftDate,
    required this.startTime,
    required this.endTime,
    required this.siteId,
    required this.nightsift,
    required this.designationId,
    this.message,
    this.created_at,
    this.created_by, 
    required this.attendanceIn, 
    required this.attendanceOut, 
    required this.attendanceDate,
  });

  // Factory method to create SlotModel from JSON
  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      id:json['slot_id']['slot_id'],
      slotName: json['slot_id']['slot_name'].toString(),
      description: json['slot_id']['description'].toString(),
      companyId: json['company_id']['company_id'].toString(),
      worksite: json['site_id']['site_name'].toString(),
      companyName: json['company_id']['company_name'].toString(),
      shiftDate: DateTime.parse(json['slot_id']['shift_date']),
      startTime: json['slot_id']['start_time'].toString(),
      attendanceIn: json['attendance_in'].toString(),
      attendanceOut: json['attendance_out'].toString(),
      attendanceDate: json['attendance_date'] != null? DateTime.parse(json['attendance_date']): null,
      endTime: json['slot_id']['end_time'].toString(),
      siteId: json['slot_id']['site_id'].toString(),
      nightsift: json['slot_id']['nightsift'].toString(),
      designationId: json['slot_id']['designation_id'].toString(),
      message: json['slot_id']['message'].toString(),
      created_at: json['slot_id']['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      created_by: json['slot_id']['created_by'].toString(),
    );
  }

  // Method to convert SlotModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'slot_name': slotName,
      'attendance_date':attendanceDate,
      'description': description,
      'company_id': companyId,
      'shift_date': shiftDate,
      'start_time': startTime,
      'end_time': endTime,
      'site_id': siteId,
      'nightsift': nightsift,
      'designation_id': designationId,
      'message': message,
      'created_at': created_at?.toIso8601String(),
      'created_by': created_by,
    };
  }
}
