import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/web_service/web_service_api.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationLoaded()) {
    on<NotificationUpdate>(notification_update);
  }

  /// Checks for the notificationenticated user in the device
  Future<void> notification_update(NotificationUpdate event, emit) async {
    try {
      // emit(NotificationLoading());
      WebServiceApi api = WebServiceApi();
      final response = await api.postNoti(event.id, event.confirmation);
      if (response != "") {
        if (response.statusCode == 200) {
          emit(const NotificationSuccess('Successfully Updated Response'));
        } else {
          emit(const NotificationError('Failed to update confirmation',
              errorLoading: true));
        }
      } else {
        emit(const NotificationError('Failed to update confirmation',
            errorLoading: true));
      }
    } catch (e) {
      emit(NotificationError(e.toString(), errorLoading: true));
    }
  }
}
