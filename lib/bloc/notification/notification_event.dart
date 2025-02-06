part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

final class NotificationUpdate extends NotificationEvent {
  final int id;
  final int confirmation;

  const NotificationUpdate({required this.id, required this.confirmation});

  @override
  List<Object> get props => [id, confirmation];
}
