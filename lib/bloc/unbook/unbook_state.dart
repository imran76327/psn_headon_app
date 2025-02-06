part of 'unbook_bloc.dart';

sealed class UnbookState extends Equatable {
  const UnbookState();

  @override
  List<Object> get props => [];
}

// Loading state while data is being fetched or processed
final class UnbookLoading extends UnbookState {}

// State representing that the initial loading of data has completed
final class UnbookLoaded extends UnbookState {}

// Error state with optional `errorLoading` flag and a message
final class UnbookError extends UnbookState {
  final String message;
  final bool errorLoading;

  const UnbookError(this.message, {this.errorLoading = false});

  @override
  List<Object> get props => [message, errorLoading];
}

// Success state with a success message
final class UnbookSuccess extends UnbookState {
  final String message;

  const UnbookSuccess(this.message);

  @override
  List<Object> get props => [message];
}
