
part of 'show_notification_bloc.dart';



abstract class ShowNotificationEvent {}

class FetchNotifications extends ShowNotificationEvent {
  final String employeeId;

  FetchNotifications({required this.employeeId});
}
