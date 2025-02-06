part of 'save_notification_bloc.dart';

abstract class SaveNotificationEvent {}

class SaveNotification extends SaveNotificationEvent {
  final String employeeId;
  final int notificationId;

  SaveNotification({required this.employeeId, required this.notificationId});
}
