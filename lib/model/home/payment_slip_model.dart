class PaySlip {
  final String result;
  final Slot slot;
  final String employeeName;
  final String employeeId;
  final List<SalaryElement> salaryElements;
  final String dateGenerated;

  PaySlip({
    required this.result,
    required this.slot,
    required this.employeeName,
    required this.employeeId,
    required this.salaryElements,
    required this.dateGenerated,
  });

  factory PaySlip.fromJson(Map<String, dynamic> json) {
    return PaySlip(
      result: json['result'] ?? '',
      slot: Slot.fromJson(json['slot']),
      employeeName: json['employee_name']?.trim() ?? 'N/A',
      employeeId: json['employee_id'] ?? 'N/A',
      salaryElements: (json['salary_elements'] as List)
          .map((e) => SalaryElement.fromJson(e))
          .toList(),
      dateGenerated: json['date_generated'] ?? '',
    );
  }
}

class Slot {
  final String slotName;
  final String shiftDate;

  Slot({
    required this.slotName,
    required this.shiftDate,
  });

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      slotName: json['slot_name'] ?? 'N/A',
      shiftDate: json['shift_date'] ?? '',
    );
  }
}

class SalaryElement {
  final String type;
  final String name;
  final double amount;

  SalaryElement({
    required this.type,
    required this.name,
    required this.amount,
  });

  factory SalaryElement.fromJson(Map<String, dynamic> json) {
    return SalaryElement(
      type: json['type'] ?? 'Unknown',
      name: json['name'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
