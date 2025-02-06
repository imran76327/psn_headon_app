part of 'save_notification_bloc.dart';

abstract class SaveNotificationState {}

class SaveNotificationInitial extends SaveNotificationState {}

class SaveNotificationLoading extends SaveNotificationState {}

class SaveNotificationSuccess extends SaveNotificationState {}

class SaveNotificationError extends SaveNotificationState {
  final String message;

  SaveNotificationError({required this.message});
}
