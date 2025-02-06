import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/home/roster_model.dart';
import '../../services/web_service/web_service_api.dart';

part 'slot_event.dart';
part 'slot_state.dart';


class RosterBloc extends Bloc<RosterEvent, RosterState> {
  RosterBloc() : super(RosterLoading()) {
    on<FetchRoster>(mapEventToState);
  }

  /// Checks for the rosterenticated user in the device
  Future<void> mapEventToState(FetchRoster event, emit) async {
    try {
      // emit(RosterLoading());
      WebServiceApi api = WebServiceApi();
      final List<RosterModel> model = await api.fetchSlotRecords();

      emit(RosterLoaded(rosterRecords: model));
    } catch (e) {
      emit(RosterError(e.toString(), errorLoading: true));
    }
  }
}
