part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {
  final bool errorLoading; // Specifies if this error is related to loading
  final String message;

  const HomeError(this.message, {this.errorLoading = false});

  @override
  List<Object> get props => [message];
}

final class HomeSuccess extends HomeState {
  final HomeModel home;

  const HomeSuccess(this.home);

  @override
  List<Object> get props => [home];
}
