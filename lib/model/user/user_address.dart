class UserAddress {
  final int id;
  final int user;
  final String address_name;
  final double latitude;
  final double longitude;
  final String address_line1;
  final String address_line2;
  final String postal_code;
  final String landmark;
  final String state;
  final String city;
  final DateTime? created_at;
  final String? created_by;
  final DateTime? updated_at;
  final String? updated_by;

  UserAddress({
    required this.id,
    required this.user,
    required this.address_name,
    required this.latitude,
    required this.longitude,
    required this.address_line1,
    required this.address_line2,
    required this.postal_code,
    required this.landmark,
    required this.state,
    required this.city,
    this.created_at,
    this.created_by,
    this.updated_at,
    this.updated_by,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
        id: json['id'],
        user: json['user'],
        address_name: json['address_name'],
        latitude: double.parse(json['latitude'].toString()),
        longitude: double.parse(json['longitude'].toString()),
        address_line1: json['address_line1'],
        address_line2: json['address_line2'],
        postal_code: json['postal_code'],
        landmark: json['landmark'],
        state: json['state'],
        city: json['city'],
        created_at: json['created_at'] == null || json['created_at'] == ""
            ? null
            : DateTime.parse(json['created_at']),
        created_by: json['created_by'],
        updated_at: json['updated_at'] == null || json['updated_at'] == ""
            ? null
            : DateTime.parse(json['updated_at']),
        updated_by: json['updated_by']);
  }
}
