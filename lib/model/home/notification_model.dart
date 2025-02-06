class NotificationModel {
  final int id;
  final String employeeId;
  final String notificationMessage;
  final String createdAt;
  final String updatedAt;
  final String type;
  final int empId;
  final int createdBy;
  final int? updatedBy;

  NotificationModel({
    required this.id,
    required this.employeeId,
    required this.notificationMessage,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.empId,
    required this.createdBy,
    this.updatedBy,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      employeeId: json['employee_id'],
      notificationMessage: json['notification_message'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      type: json['type']['parameter_value'],
      empId: json['emp_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'notification_message': notificationMessage,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'type': type,
      'emp_id': empId,
      'created_by': createdBy,
      'updated_by': updatedBy,
    };
  }
}
