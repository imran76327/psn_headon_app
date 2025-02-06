class SalaryData {
  final String employeeId;
  final String elementName;
  final String payType;
  final String amount;
  final DateTime salaryDate;
  final String slotName; // Use DateTime for date handling.

  // Constructor
  SalaryData({
    required this.employeeId,
    required this.elementName,
    required this.payType,
    required this.amount,
    required this.salaryDate, 
    required this.slotName,
  });

  // Factory constructor to create a SalaryData instance from JSON
  factory SalaryData.fromJson(Map<String, dynamic> json) {
    return SalaryData(
      salaryDate: DateTime.parse(json['created_at']).toLocal(),
      slotName : json['slot_id']['slot_name'] as String,// Parse and localize the datetime.
      employeeId: json['employee_id'] as String,
      elementName: json['element_name'] as String,
      payType: json['pay_type'] as String,
      amount: json['amount'] as String,
    );
  }

  // Method to convert a SalaryData instance into JSON
  Map<String, dynamic> toJson() {
    return {
      'employee_id': employeeId,
      'element_name': elementName,
      'pay_type': payType,
      'amount': amount,
      'created_at': salaryDate.toIso8601String(), // Convert back to ISO 8601 format.
    };
  }

  // Getter to return only the date portion as a string
  String get formattedDate {
    return "${salaryDate.year}-${salaryDate.month.toString().padLeft(2, '0')}-${salaryDate.day.toString().padLeft(2, '0')}";
  }
}
