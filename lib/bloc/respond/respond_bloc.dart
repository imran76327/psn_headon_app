import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/web_service/web_service_api.dart';

part 'respond_event.dart';
part 'respond_state.dart';

class RespondBloc extends Bloc<RespondEvent, RespondState> {
  RespondBloc() : super(RespondLoaded()) {
    on<RespondFetch>(respondFetch);
  }

  /// Checks for the respondenticated user in the device
  Future<void> respondFetch(RespondFetch event, emit) async {
    try {
      emit(RespondLoading());
      WebServiceApi api = WebServiceApi();
      final response = await api.postResponse(event.slotId, event.siteId,event.companyId, event.employee_Id, event.mobileNum);
      if (response != "") {
        if (response.statusCode == 200) {
          emit(const RespondSuccess('Successfully Updated Response'));
        } else {
          emit(const RespondError('Failed to update confirmation',
              errorLoading: true));
        }
      } else {
        emit(const RespondError('Failed to update confirmation', errorLoading: true));
      }
    } catch (e) {
      emit(RespondError(e.toString(), errorLoading: true));
    }
  }
}
