part of 'slot_bloc.dart';

sealed class RosterEvent extends Equatable {
  const RosterEvent();

  @override
  List<Object> get props => [];
}

class FetchRoster extends RosterEvent {}

final class RosterUpdate extends RosterEvent {
  final int id;
  final int confirmation;

  const RosterUpdate({required this.id, required this.confirmation});

  @override
  List<Object> get props => [id, confirmation];
}
