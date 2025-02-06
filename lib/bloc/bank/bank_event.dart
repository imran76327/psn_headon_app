part of 'bank_bloc.dart';
abstract class BankPostEvent {}

class BankPost extends BankPostEvent {
  final String employeeId;
  final String companyId;
  final String accountHolderName;
  final String accountNo;
  final String bankName;
  final String branchName;
  final String ifsc;
  final String phone;

  BankPost({
    required this.employeeId,
    required this.companyId,
    required this.accountHolderName,
    required this.accountNo,
    required this.bankName,
    required this.branchName,
    required this.ifsc,
    required this.phone
  });
}
