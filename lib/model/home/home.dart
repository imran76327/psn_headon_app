import 'package:headon/model/home/salary_model.dart';
import 'package:headon/model/home/user_slot_model.dart';
import 'package:headon/model/home/slot_model.dart';
import 'package:headon/model/home/slot_list_model.dart';
import 'package:headon/model/home/utr_model.dart';



class HomeModel {
  final int slot_alloted_count;
  final List<SlotModel> slot_alloted_list;
  final int slot_attended_count;
  final List<SlotModel> slot_attended_list;
  final int wage_period_count;
  final List<SalaryData> wage_period_list;
  final int utr_count;
  final List<UtrData> utr_list;
  final String employeeId;  
  final List<SlotListModel> slot_details_list;
  final List<UserSlotModel> user_slot_list;
  final String mobileNo;
  final String name;

  HomeModel({
    required this.slot_alloted_count,
    required this.slot_alloted_list,
    required this.slot_attended_count,
    required this.slot_attended_list,
    required this.wage_period_count,
    required this.wage_period_list,
    required this.utr_count,
    required this.utr_list,
    required this.slot_details_list,
    required this.user_slot_list,
    required this.employeeId,
    required this.mobileNo,
    required this.name
  });


  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      
      slot_alloted_count: json['slot_alloted_count'] ?? 0,
      slot_alloted_list: (json['slot_alloted_list'] as List<dynamic>?)
              ?.map((item) => SlotModel.fromJson(item))
              .toList() ??
          [],
      slot_attended_count: json['user_attendance_count'] ?? 0,
      slot_attended_list: (json['user_attendance_list'] as List<dynamic>?)
              ?.map((item) => SlotModel.fromJson(item))
              .toList() ??
          [],
      wage_period_count: json['wage_count'] ?? 0,
      wage_period_list: (json['salary_data'] as List<dynamic>?)
              ?.map((item) => SalaryData.fromJson(item))
              .toList() ??
          [],
      utr_count: json['utr_count'] ?? 0,
      utr_list: (json['utr_data'] as List<dynamic>?)
              ?.map((item) => UtrData.fromJson(item))
              .toList() ??
          [],
     slot_details_list: (json['slot_details_list'] as List<dynamic>)
          .map((item) => SlotListModel.fromJson(item))
          .toList() ,
     user_slot_list: (json['slot_count_list'] as List<dynamic>)
          .map((item) => UserSlotModel.fromJson(item))
          .toList() ,
      employeeId: json['employee_id'].toString(),
      mobileNo: json['mobile_no'].toString(),
      name : json['name']
    );
  
  }
}
