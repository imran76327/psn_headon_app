import 'package:bloc/bloc.dart';
import 'package:headon/model/home/stateModal.dart';

import '../../services/web_service/web_service_api.dart';

part 'stateName_event.dart';
part 'stateName_state.dart';

class StateNameBloc extends Bloc<StateNameEvent, StateNameState> {
  StateNameBloc() : super(StateNameInitial()) {
    on<FetchStateName>(StateNames);
  }

  /// Fetches the state names from the API
  Future<void> StateNames(FetchStateName event, Emitter<StateNameState> emit) async {
    emit(StateNameLoading()); // Emit loading state before the API call
    try {
      WebServiceApi api = WebServiceApi();
      // Fetching state names
      final List<StateModal> stateModal = await api.fetchStateName();
      // Assuming StateModal has a method to get state names as a List<String>
 

      emit(StateNameLoaded(stateModal )); // Emit loaded state with the list of state names
    } catch (e) {
      print('Error fetching state names: $e');
      emit(StateNameError(e.toString(), errorLoading: true)); // Emit error state with the error message
    }
  }
}
