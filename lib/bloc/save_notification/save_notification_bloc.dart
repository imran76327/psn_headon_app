import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../services/web_service/web_service_api.dart';



part 'save_notification_event.dart';
part 'save_notification_state.dart';


/// Bloc class to handle notification saving
class SaveNotificationBloc extends Bloc<SaveNotificationEvent, SaveNotificationState> {
  SaveNotificationBloc() : super(SaveNotificationInitial()) {
    on<SaveNotification>(saveNotification);
  }

  /// Method to send the notification ID and employee ID to the API and handle the response
  Future<void> saveNotification(SaveNotification event, Emitter<SaveNotificationState> emit) async {
    try {
      // Emit a loading state while the API call is in progress
      emit(SaveNotificationLoading());

      WebServiceApi api = WebServiceApi();
      // Pass the notification ID and employee ID to the API
      final Response response = await api.postNotification(
        id: event.notificationId,
        employeeId: event.employeeId,
      );
      
      if (response.statusCode == 200) {
        // Emit success state if the API call is successful
        emit(SaveNotificationSuccess());
      } else {
        // Emit error state with an appropriate message for non-200 responses
        emit(SaveNotificationError(
          message: 'Failed to update notification. Please try again.',
        ));
      }
    } catch (e) {
      // Emit error state with the exception message
      emit(SaveNotificationError(
        message: "Error: ${e.toString()}",
      ));
    }
  }
}
