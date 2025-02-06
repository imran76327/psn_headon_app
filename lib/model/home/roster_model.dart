
class RosterModel {
  final int id;
  final int slotId;
  final String slotName;
  final DateTime shiftDate;
  final String shiftTime;
  final String endTime;
  final int companyId;
  final String companyName;
  final int siteId;
  final String siteName;
  final int empId;
  final String employeeName;
  final String employeeId;
  final DateTime? createdAt;
  final String? createdBy;
  final int attendanceCheck;

  RosterModel( {
    required this.id,
    required this.slotId,
    required this.slotName,
    required this.employeeName,
    required this.siteName,
    required this.shiftDate,
    required this.shiftTime,
    required this.endTime,
    required this.companyId,
    required this.companyName,
    required this.employeeId,
    required this.empId,
    required this.siteId,
    this.createdAt,
    this.createdBy,
    required this.attendanceCheck,
  });

   factory RosterModel.fromJson(Map<String, dynamic> json) {
    return RosterModel(
      id: json['id'],
      slotId: json['slot_id']['slot_id'],
      slotName: json['slot_id']['slot_name'],
      shiftDate: DateTime.parse(json['slot_id']['shift_date']),
      shiftTime: json['slot_id']['start_time'],
      endTime: json['slot_id']['end_time'],
      companyId: json['company_id']['company_id'],
      companyName: json['company_id']['company_name'],
      siteId: json['site_id']['site_id'],
      siteName: json['site_id']['site_name'],
      empId: json['emp_id']['id'],
      employeeName: json['emp_id']['employee_name'],
      employeeId: json['employee_id'],
      createdAt: json['created_at'] == null || json['created_at'] == ""
          ? null
          : DateTime.parse(json['created_at']),
      createdBy: json['created_by']?.toString(),
      attendanceCheck: json['attendance_check'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slot_id': slotId,
      'slot_name': slotName,
      'shift_date': shiftDate,
      'shift_time': shiftTime,
      'end_time':endTime,
      'company_id': companyId,
      'company_name': companyName,
      'site_id': siteId,
      'site_name': siteName,
      'emp_id': empId,
      'employee_name': employeeName,
      'employee_id': employeeId,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'attendance_check':attendanceCheck
    };
  }
}


