import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/home/notification_model.dart';
import '../../services/web_service/web_service_api.dart';
part 'show_notification_event.dart';
part 'show_notification_state.dart';


class ShowNotificationBloc extends Bloc<ShowNotificationEvent, ShowNotificationState> {
  ShowNotificationBloc() : super(ShowNotificationLoading()) {
    on<FetchNotifications>(_fetchNotifications);
  }

  /// Fetch notifications from the API and emit corresponding states
  Future<void> _fetchNotifications(FetchNotifications event, Emitter<ShowNotificationState> emit) async {
    try {
      emit(ShowNotificationLoading());
      WebServiceApi api = WebServiceApi();
      // Fetch the list of notifications from the API
      final List<NotificationModel> notifications = await api.fetchNotificationDetails(event.employeeId);
      emit(ShowNotificationSuccess(notifications));
    } catch (e) {
      // emit(ShowNotificationError('Failed to load notifications: ${e.toString()}', errorLoading: true));
      // ignore: prefer_const_constructors
      emit(ShowNotificationError('No New Notifications'));
    }
  }
}
