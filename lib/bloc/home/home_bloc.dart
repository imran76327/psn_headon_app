import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/home/home.dart';
import '../../services/web_service/web_service_api.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<HomeFetch>(homeFetch);
  }

  /// Checks for the homeenticated user in the device
  Future<void> homeFetch(HomeFetch event, emit) async {
    try {
      WebServiceApi api = WebServiceApi();
      final HomeModel home = await api.fetchHomePageDetails();
      print(home);
      emit(HomeSuccess(home));
    } catch (e) {
      print('error');
      print(e);
      emit(HomeError(e.toString(), errorLoading: true));
    }
  }
}
