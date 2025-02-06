part of 'stateName_bloc.dart';

abstract class StateNameState {}

class StateNameInitial extends StateNameState {}

class StateNameLoading extends StateNameState {}

class StateNameLoaded extends StateNameState {
  final List<StateModal> stateNames; 

  StateNameLoaded(this.stateNames);
}

class StateNameError extends StateNameState {
  final String message;
  final bool errorLoading; // Added this field to keep track of loading error status

  StateNameError(this.message, {required this.errorLoading});
}
