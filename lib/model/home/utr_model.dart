class UtrData {
  final int payoutId;
  final String employeeId;
  final int companyId;
  final int slotId;
  final String razorpayPayoutId;
  final String fundAccountId;
  final double amount;
  final double fees;
  final double tax;
  final String? utr;
  final String? failureReason;
  final int payoutStatusId;
  final String payoutForDate;
  final String? paymentInitiatedDate;
  final DateTime paymentCompletedDate;
  final String referenceId;
  final String purpose;
  final String createdAt;
  final int createdById;
  final String updatedAt;
  final int updatedById;

  UtrData({
    required this.payoutId,
    required this.employeeId,
    required this.companyId,
    required this.slotId,
    required this.razorpayPayoutId,
    required this.fundAccountId,
    required this.amount,
    required this.fees,
    required this.tax,
    this.utr,
    this.failureReason,
    required this.payoutStatusId,
    required this.payoutForDate,
    this.paymentInitiatedDate,
    required this.paymentCompletedDate,
    required this.referenceId,
    required this.purpose,
    required this.createdAt,
    required this.createdById,
    required this.updatedAt,
    required this.updatedById,
  });

  // Factory constructor to create an instance from JSON data
  factory UtrData.fromJson(Map<String, dynamic> json) {
    return UtrData(
      payoutId: json['payout_id'],
      employeeId: json['employee_id'],
      companyId: json['company_id_id'],
      slotId: json['slot_id_id'],
      razorpayPayoutId: json['razorpay_payout_id'],
      fundAccountId: json['fund_account_id'],
      amount: json['amount'].toDouble(),
      fees: json['fees'].toDouble(),
      tax: json['tax'].toDouble(),
      utr: json['utr'],
      failureReason: json['failure_reason'],
      payoutStatusId: json['payout_status_id'],
      payoutForDate: json['payout_for_date'],
      paymentInitiatedDate: json['payment_initiated_date'],
      paymentCompletedDate: DateTime.parse(json['created_at']).toLocal(),
      referenceId: json['reference_id'],
      purpose: json['purpose'],
      createdAt: json['created_at'],
      createdById: json['created_by_id'],
      updatedAt: json['updated_at'],
      updatedById: json['updated_by_id'],
    );
  }

  // Method to convert the instance back into JSON format
  Map<String, dynamic> toJson() {
    return {
      'payout_id': payoutId,
      'employee_id': employeeId,
      'company_id_id': companyId,
      'slot_id_id': slotId,
      'razorpay_payout_id': razorpayPayoutId,
      'fund_account_id': fundAccountId,
      'amount': amount,
      'fees': fees,
      'tax': tax,
      'utr': utr,
      'failure_reason': failureReason,
      'payout_status_id': payoutStatusId,
      'payout_for_date': payoutForDate,
      'payment_initiated_date': paymentInitiatedDate,
      'payment_completed_date': paymentCompletedDate,
      'reference_id': referenceId,
      'purpose': purpose,
      'created_at': createdAt,
      'created_by_id': createdById,
      'updated_at': updatedAt,
      'updated_by_id': updatedById,
    };
  }

   String get formattedDate {
    return "${paymentCompletedDate.year}-${paymentCompletedDate.month.toString().padLeft(2, '0')}-${paymentCompletedDate.day.toString().padLeft(2, '0')}";
  }
}
