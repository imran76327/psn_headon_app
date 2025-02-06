part of 'bank_bloc.dart';
abstract class BankPostState {
 
}

class BankPostInitial extends BankPostState {}

class BankPostLoading extends BankPostState {}

class BankPostSuccess extends BankPostState {
  final String messages;
  BankPostSuccess(this.messages);

  String get message => "The Bank Details You Entered is valid and Successfully Updated";

}

class BankPostFailure extends BankPostState {
  final String error;

  BankPostFailure(this.error, {required bool errorLoading});

  String get message => "The provided Bank Details is not valid";
}
