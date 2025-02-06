part of 'respond_bloc.dart';

sealed class RespondEvent extends Equatable {
  const RespondEvent();

  @override
  List<Object> get props => [];
}

final class RespondFetch extends RespondEvent {
  final int slotId;
  final int companyId;
  final int siteId;
  final String employee_Id;
  final String mobileNum;

  const RespondFetch( {
    required this.slotId,
     required this.companyId,
    required this.siteId, 
    required this.employee_Id, 
    required this.mobileNum
  });

  @override
  List<Object> get props => [slotId,companyId, siteId, employee_Id , mobileNum];
}
