part of 'unbook_bloc.dart';

sealed class UnbookEvent extends Equatable {
  const UnbookEvent();

  @override
  List<Object> get props => [];
}

final class Unbookfetch extends UnbookEvent {
  final int slotId;
  final int id;
  final String employeeId;

  const Unbookfetch( {
    required this.slotId,
    required this.id,
    required this.employeeId
  });

  @override
  List<Object> get props => [slotId,id,employeeId ];
}
