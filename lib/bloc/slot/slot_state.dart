part of 'slot_bloc.dart';

sealed class RosterState extends Equatable {
  const RosterState();

  @override
  List<Object> get props => [];
}

class RosterInitial extends RosterState {}

final class RosterLoading extends RosterState {}

class RosterLoaded extends RosterState {
  final List<RosterModel> rosterRecords;

  const RosterLoaded({required this.rosterRecords});

  @override
  List<Object> get props => [rosterRecords];
}

final class RosterError extends RosterState {
  final bool errorLoading; // Specifies if this error is related to loading
  final String message;

  const RosterError(this.message, {this.errorLoading = false});

  @override
  List<Object> get props => [message];
}

final class RosterSuccess extends RosterState {
  final String message;

  const RosterSuccess(this.message);

  @override
  List<Object> get props => [message];
}
