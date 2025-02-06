
  class UserSlotModel {
  final int id;
  final String employeeId;
  final int slotid;   // New field for employee ID
  final int count;// New field for site ID

  UserSlotModel({
    required this.employeeId,
    required this.slotid,
    required this.id,
    required this.count,
  });

  // Factory method to create a UserSlotModel instance from a JSON map
  factory UserSlotModel.fromJson(Map<String, dynamic> json) {
    return UserSlotModel( 
      id: json['id'],
      slotid: json['slotId'],
      employeeId: json['employeeId'],
      count: json['count']      // Added site ID
    );
  }


  // Method to convert UserSlotModel instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'slot_id': slotid,  
      'employee_id':employeeId,    // Include company ID in JSON
      'count': count             // Include site ID in JSON
    };
  }
}
