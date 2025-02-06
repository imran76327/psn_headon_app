class PaymentSlip {
  final int id;
  final String slotName;
  final String employeeId;
  final String createdAt;
  final String updatedAt;
  final int companyId;
  final int createdBy;
  final int updatedBy;
  final int slotId;

  PaymentSlip({
    required this.id,
    required this.slotName,
    required this.employeeId,
    required this.createdAt,
    required this.updatedAt,
    required this.companyId,
    required this.createdBy,
    required this.updatedBy, required this.slotId,
  });

  factory PaymentSlip.fromJson(Map<String, dynamic> json) {
    return PaymentSlip(
      id: json['id'],
      slotName: json['slot_id']['slot_name'],
      slotId: json['slot_id']['slot_id'],
      employeeId: json['employee_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      companyId: json['company_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slot_id'
      'slot_name': slotName,
      'employee_id': employeeId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'company_id': companyId,
      'created_by': createdBy,
      'updated_by': updatedBy,
    };
  }
}
