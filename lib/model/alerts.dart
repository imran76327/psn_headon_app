// import 'dart:convert';

// import 'package:flutter/material.dart';

class Alerts {
  final String id, alert_text;

  Alerts(this.id, this.alert_text);

  Map<String, dynamic> toJson() {
    return {'id': id, 'alert_text': alert_text};
  }

  factory Alerts.fromJson(Map<String, dynamic> json) {
    return Alerts(json['id'], json['alert_text']);
  }
}
// shiftType:json['shiftType']
//       shiftType: json['shiftType'],
//       shiftDate: json['shiftDate'],
//       age: json['age'],
//       age: json['age'],
//       age: json['age'],
//       age: json['age'],

// String jsonData = '''
//   [
//     {
//       "shiftType": "Leave",
//       "shiftDate": "09 Feb 2023",
//       "shiftStartTime": "-- -- --",
//       "shiftEndTime": "-- -- --",
//       "shiftStatus": "LEAVE"
//     },
//     {
//       "shiftType": "Working",
//       "shiftDate": "09 Feb 2023",
//       "shiftStartTime": "06:00 PM",
//       "shiftEndTime": "06:00 PM",
//       "shiftStatus": "Leave Early"
//     },
//      {
//       "shiftType": "Working",
//       "shiftDate": "10 Feb 2023",
//       "shiftStartTime": "06:00 PM",
//       "shiftEndTime": "06:00 PM",
//       "shiftStatus": "Leave Early"
//     },
//        {
//       "shiftType": "Working",
//       "shiftDate": "11 Feb 2023",
//       "shiftStartTime": "06:00 PM",
//       "shiftEndTime": "06:00 PM",
//       "shiftStatus": "Leave Early"
//     },
//          {
//       "shiftType": "Working",
//       "shiftDate": "12 Feb 2023",
//       "shiftStartTime": "06:00 PM",
//       "shiftEndTime": "06:00 PM",
//       "shiftStatus": "Leave Early"
//     },
//     {
//       "shiftType": "Working",
//       "shiftDate": "13 Feb 2023",
//       "shiftStartTime": "06:00 PM",
//       "shiftEndTime": "06:00 PM",
//       "shiftStatus": "Leave Early"
//     }
  
    
//   ]
//   ''';

// List<Map<String, dynamic>> jsonList =
//     List<Map<String, dynamic>>.from(jsonDecode(jsonData));

// // Convert List<Map<String, dynamic>> to List<RecentAttendance>
// List<Alerts> recentAttendanceList = jsonList.map((json) {
//   return Alerts(
//     json['shiftType'],
//     json['shiftDate'],
//     json['shiftStartTime'],
//     json['shiftEndTime'],
//     json['shiftStatus'],
//   );
// }).toList();
