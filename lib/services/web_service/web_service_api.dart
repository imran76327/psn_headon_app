


import 'package:dio/src/response.dart';
import 'package:headon/model/home/employee_model.dart';
import 'package:headon/model/home/notification_model.dart';

import '../../model/home/home.dart';
import '../../model/home/payment_modal.dart';
import '../../model/home/payment_slip_model.dart';
import '../../model/home/roster_model.dart';
import '../../model/home/stateModal.dart';
import '../service_helper.dart';
import 'web_service.dart';

class WebServiceApi implements WebService {
  final _api = ServiceHelper().dio;

  @override
  fetchHomePageDetails() async {
    try {
      final response = await _api.get('/home_slot_fetch');

      final home = HomeModel.fromJson(response.data);
      return home;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Response> postEmployeeDetails({required String employeeId, required String companyId, required String email, required String address,
   required String city, String? selectedStateId, required pincode}) async {
  try {
    // Adjust the API endpoint to include the parameters if necessary
   final response = await _api.put('/employee_data', data: {
      'employee_id': employeeId,
      'company_id':companyId,
      'email': email,
      'address': address,
      'city': city,
      'pincode':pincode,
      'state_id':selectedStateId
    });

    return response;
  } catch (e) {
    print(e.toString());
    throw Exception('Failed to Post employee details');
  }
}

  Future<Response> postBankDetails({required String employeeId, required String companyId, required String accountHolderName, 
  required String accountNo, required String bankName, required String branchName,
    required String ifsc ,required String phone}) async {
  try {
    // Adjust the API endpoint to include the parameters if necessary
   final response = await _api.post('/update_bank_details', data: {
      'employee_id': employeeId,
      'company_id':companyId,
      'holder_name': accountHolderName,
      'account_no': accountNo,
      'bank_name': bankName,
      'branch_name': branchName,
      'ifsc': ifsc,
      'phone':phone
    });

    return response;
  } catch (e) {
    print(e.toString());
    throw Exception('Failed to Post Bank details');
  }
}

 Future<List<StateModal>> fetchStateName() async {
  try {
    // Adjust the API endpoint to include the parameters if necessary
    final response = await _api.get('/StateName');

    // Assuming the response contains the employee data
    // final stateName = StateModal.fromJson(response.data);
    final List<StateModal> stateList = (response.data as List)
    .map((stateJson) => StateModal.fromJson(stateJson))
    .toList();
    return stateList;
  } catch (e) {
    print(e.toString());
    throw Exception('Failed to fetch employee details');
  }
}

  Future<EmployeeModal> fetchEmployeeDetails(String employeeId, String companyId) async {
  try {
    // Adjust the API endpoint to include the parameters if necessary
    final response = await _api.get('/employee_data', data: {
      'employee_id': employeeId,
      'company_id': companyId,
    });

    // Assuming the response contains the employee data
    final employee = EmployeeModal.fromJson(response.data);
    return employee;
  } catch (e) {
    print(e.toString());
    throw Exception('Failed to fetch employee details');
  }
}
Future<List<NotificationModel>> fetchNotificationDetails(String employeeId) async {
  try {
    // Adjust the API endpoint to include the parameters if necessary
    final response = await _api.get('/show_notification', data: {
      'employee_id': employeeId,
    });

    // Assuming the response contains a list of notifications
    List<dynamic> notificationList = response.data;  // Assuming response is a List of notifications
    List<NotificationModel> notifications = notificationList
        .map((json) => NotificationModel.fromJson(json)) // Map each JSON object to NotificationModel
        .toList(); // Convert the iterable into a List

    return notifications;
  } catch (e) {
    print(e.toString());
    throw Exception('Failed to fetch Notification details');
  }
}


 fetchPaymentDetails(String employeeId) async {
    try {
      final response = await _api.get('/payment_details',  data:  {'employee_id': employeeId,}
      );
      if (response.statusCode == 200) {
        List<PaymentSlip> paymentRecords = (response.data as List<dynamic>)
            .map((item) => PaymentSlip.fromJson(item))
            .toList();
        return paymentRecords;
      } else {
        throw Exception('Failed to load roster data');
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

Future<PaySlip> fetchPaymentSlipDetails(String employeeId, int slotId) async {
  try {
    // API call to fetch payment slip details
    final response = await _api.get(
      '/payment_slip_details',
      data: {'employee_id': employeeId, 'slot_id': slotId},
    );

    if (response.statusCode == 200 && response.data != null) {
      // Map response data to PaymentSlip model
      final paymentSlip = PaySlip.fromJson(response.data);
      return paymentSlip;
    } else {
      throw Exception('Failed to fetch payment slip');
    }
  } catch (e) {
    print('Error fetching payment slip: $e');
    throw Exception('Error fetching payment slip: $e');
  }
}




@override
dynamic postResponse(int slotId, int siteId,int companyId, String employeeId, String mobileNum) {
  return Future(() async {
    try {
      final response = await _api.post(
        '/post_user_slot',
        data: {
          'slot_id': slotId,
          'site_id': siteId,
          'company_id': companyId,
          'employee_id':employeeId,
          'mobileNum': mobileNum
        },
      );

      return response;
      } catch (e) {
      print("Exception: ${e.toString()}");
      return null;
    }
  });
}
@override
dynamic deleteUserSlot(int slotId,int id, String employeeId) {
  return Future(() async {
    try {
      final response = await _api.delete(
        '/delete_user_slot',
        data: {
          'employee_id':employeeId,
          'slot_id': slotId,
          'id': id,
        },
      );

      return response;
      } catch (e) {
      print("Exception: ${e.toString()}");
      return null;
    }
  });
}


  postNoti(int id, int confirmation) async {
    try {
      final response = await _api.post(
        '/confirm_notification',
        data: {
          'id': id,
          'confirmation': confirmation.toString(),
        },
      );
      return response;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  postNotification({required String employeeId, required int id}) async {
    try {
      final response = await _api.post(
        '/save_notification',
        data: {
          'id': id,
          'employee_id':employeeId
        },
      );
      return response;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  fetchSlotRecords() async {
    try {
      final response = await _api.get(
        '/DefaultRecords',
      );
      if (response.statusCode == 200) {
        List<RosterModel> rosterRecords = (response.data as List<dynamic>)
            .map((item) => RosterModel.fromJson(item))
            .toList();
        return rosterRecords;
      } else {
        throw Exception('Failed to load roster data');
      }
    } catch (e) {
      print(e.toString());
      return "";
    }
  }
}

