class CompanyModel {
  final int company_id;
  final String company_name;
  final String company_address;
  final String pincode;
  final String contact_person_name;
  final String contact_person_email;
  final String contact_person_mobile_no;
  final bool is_active;
  final DateTime? created_at;
  final String? created_by;
  final DateTime? updated_at;
  final String? updated_by;

  CompanyModel({
    required this.company_id,
    required this.company_name,
    required this.company_address,
    required this.pincode,
    required this.contact_person_name,
    required this.contact_person_email,
    required this.contact_person_mobile_no,
    required this.is_active,
    this.created_at,
    this.created_by,
    this.updated_at,
    this.updated_by,
  });
  Map<String, dynamic> toJson() {
    return {
      'company_id': company_id,
      'company_name': company_name,
      'company_address': company_address,
      'pincode': pincode,
      'contact_person_name': contact_person_name,
      'contact_person_email': contact_person_email,
      'contact_person_mobile_no': contact_person_mobile_no,
      'is_active': is_active,
      'created_at': created_at?.toIso8601String(), // Convert DateTime to String
      'created_by': created_by,
      'updated_at': updated_at?.toIso8601String(), // Convert DateTime to String
      'updated_by': updated_by,
    };
  }

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        company_id: json['company_id'],
        company_name: json['company_name'],
        company_address: json['company_address'],
        pincode: json['pincode'].toString(),
        contact_person_name: json['contact_person_name'],
        contact_person_email: json['contact_person_email'],
        contact_person_mobile_no: json['contact_person_mobile_no'],
        is_active: json['is_active'],
        created_at: json['created_at'] == null || json['created_at'] == ""
            ? null
            : DateTime.parse(json['created_at']),
        created_by: json['created_by'].toString(),
        updated_at: json['updated_at'] == null || json['updated_at'] == ""
            ? null
            : DateTime.parse(json['updated_at']),
        updated_by: json['updated_by'].toString());
  }
}
