import 'dart:convert';

// import 'package:flutter/material.dart';

class RecentAttendance {
  final String shiftType, shiftDate, shiftStartTime, shiftEndTime, shiftStatus;

  RecentAttendance(this.shiftType, this.shiftDate, this.shiftStartTime,
      this.shiftEndTime, this.shiftStatus);

  Map<String, dynamic> toJson() {
    return {
      'shiftType': shiftType,
      'shiftDate': shiftDate,
      'shiftStartTime': shiftStartTime,
      'shiftEndTime': shiftEndTime,
      'shiftStatus': shiftStatus,
    };
  }

  factory RecentAttendance.fromJson(Map<String, dynamic> json) {
    return RecentAttendance(
      json['shiftType'],
      json['shiftDate'],
      json['shiftStartTime'],
      json['shiftEndTime'],
      json['shiftStatus'],
    );
  }
}
// shiftType:json['shiftType']
//       shiftType: json['shiftType'],
//       shiftDate: json['shiftDate'],
//       age: json['age'],
//       age: json['age'],
//       age: json['age'],
//       age: json['age'],

String jsonData = '''
  [
    {
      "shiftType": "Leave",
      "shiftDate": "09 Feb 2023",
      "shiftStartTime": "-- -- --",
      "shiftEndTime": "-- -- --",
      "shiftStatus": "LEAVE"
    },
    {
      "shiftType": "Working",
      "shiftDate": "09 Feb 2023",
      "shiftStartTime": "06:00 PM",
      "shiftEndTime": "06:00 PM",
      "shiftStatus": "Leave Early"
    },
     {
      "shiftType": "Working",
      "shiftDate": "10 Feb 2023",
      "shiftStartTime": "06:00 PM",
      "shiftEndTime": "06:00 PM",
      "shiftStatus": "Leave Early"
    },
       {
      "shiftType": "Working",
      "shiftDate": "11 Feb 2023",
      "shiftStartTime": "06:00 PM",
      "shiftEndTime": "06:00 PM",
      "shiftStatus": "Leave Early"
    },
         {
      "shiftType": "Working",
      "shiftDate": "12 Feb 2023",
      "shiftStartTime": "06:00 PM",
      "shiftEndTime": "06:00 PM",
      "shiftStatus": "Leave Early"
    },
    {
      "shiftType": "Working",
      "shiftDate": "13 Feb 2023",
      "shiftStartTime": "06:00 PM",
      "shiftEndTime": "06:00 PM",
      "shiftStatus": "Leave Early"
    }
  
    
  ]
  ''';

List<Map<String, dynamic>> jsonList =
    List<Map<String, dynamic>>.from(jsonDecode(jsonData));

// Convert List<Map<String, dynamic>> to List<RecentAttendance>
List<RecentAttendance> recentAttendanceList = jsonList.map((json) {
  return RecentAttendance(
    json['shiftType'],
    json['shiftDate'],
    json['shiftStartTime'],
    json['shiftEndTime'],
    json['shiftStatus'],
  );
}).toList();
