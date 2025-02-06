part of 'respond_bloc.dart';

sealed class RespondState extends Equatable {
  const RespondState();

  @override
  List<Object> get props => [];
}

// Loading state while data is being fetched or processed
final class RespondLoading extends RespondState {}

// State representing that the initial loading of data has completed
final class RespondLoaded extends RespondState {}

// Error state with optional `errorLoading` flag and a message
final class RespondError extends RespondState {
  final String message;
  final bool errorLoading;

  const RespondError(this.message, {this.errorLoading = false});

  @override
  List<Object> get props => [message, errorLoading];
}

// Success state with a success message
final class RespondSuccess extends RespondState {
  final String message;

  const RespondSuccess(this.message);

  @override
  List<Object> get props => [message];
}
