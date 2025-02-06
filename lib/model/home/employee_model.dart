class EmployeeModal {
  final String employeeId;
  final String name;
  final String mobileNumber;
  final String accountHolderName;
  final String accountNo;
  final String address;
  final String bankName;
  final String branchName;
  final String state;
  final String city;
  final String companyName;
  final String employementStatus;
  final String email;
  final String esic;
  final String gender;
  final String ifscCode;
  final String pfNumber;
  final String pincode;
  final String uanNumber;
  final String companyId;
  final String StateId;

  EmployeeModal({
    required this.employeeId,
    required this.name,
    required this.mobileNumber,
    required this.accountHolderName,
    required this.accountNo,
    required this.address,
    required this.bankName,
    required this.branchName,
    required this.state,
    required this.city,
    required this.companyName,
    required this.employementStatus,
    required this.email,
    required this.esic,
    required this.gender,
    required this.ifscCode,
    required this.pfNumber,
    required this.pincode,
    required this.uanNumber,
    required this.companyId,
    required this.StateId,
  });

  // Factory constructor to parse JSON into an EmployeeDetails object
  factory EmployeeModal.fromJson(Map<String, dynamic> json) {
    return EmployeeModal(
      employeeId: json['employee_id'],
      name: json['employee_name'],
      mobileNumber: json['mobile_no'],
      accountHolderName: json['account_holder_name'],
      accountNo: json['account_no'],
      address: json['address'],
      bankName: json['bank_name'],
      branchName: json['branch_name'],
      state: json['state_id']['state_name'],
      city: json['city'],
      companyId:json['company_id']['company_id'].toString(),
      companyName: json['company_id']['company_name'],
      employementStatus: json['employment_status']['parameter_value'],
      email: json['email'],
      esic: json['esic'],
      gender: json['gender'],
      ifscCode: json['ifsc_code'],
      pfNumber: json['pf_no'],
      pincode: json['pincode'],
      uanNumber: json['uan_no'],
      StateId: json['state_id']['state_id'].toString()
    );
  }

}
