part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationLoading extends NotificationState {}

final class NotificationLoaded extends NotificationState {}

final class NotificationError extends NotificationState {
  final bool errorLoading; // Specifies if this error is related to loading
  final String message;

  const NotificationError(this.message, {this.errorLoading = false});

  @override
  List<Object> get props => [message];
}

final class NotificationSuccess extends NotificationState {
  final String message;

  const NotificationSuccess(this.message);

  @override
  List<Object> get props => [message];
}
