part of 'show_notification_bloc.dart';

abstract class ShowNotificationState extends Equatable {
  const ShowNotificationState();

  @override
  List<Object> get props => [];
}

class ShowNotificationLoading extends ShowNotificationState {}

class ShowNotificationError extends ShowNotificationState {
  final String message;
  final bool errorLoading;

  const ShowNotificationError(this.message, {this.errorLoading = false});

  @override
  List<Object> get props => [message, errorLoading];
}

class ShowNotificationSuccess extends ShowNotificationState {
  final List<NotificationModel> notifications;

  const ShowNotificationSuccess(this.notifications);

  @override
  List<Object> get props => [notifications];
}
