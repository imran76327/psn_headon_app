import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/web_service/web_service_api.dart';

part 'unbook_event.dart';
part 'unbook_state.dart';

// RespondBloc now inherits from UnbookEvent since it's handling Unbook-related actions
class UnbookBloc extends Bloc<UnbookEvent, UnbookState> {
  UnbookBloc() : super(UnbookLoaded()) {
    on<Unbookfetch>(unbookFetch);  // Handle Unbookfetch event
  }

  /// Respond to the unbooking request
  Future<void> unbookFetch(Unbookfetch event, emit) async {
    try {
      emit(UnbookLoading()); // Emit loading state before making the API call

      WebServiceApi api = WebServiceApi();
      final response = await api.deleteUserSlot(
        event.slotId,
        event.id,
        event.employeeId
      );

      // Handle the API response
      if (response != "") {
        if (response.statusCode == 200) {
          emit(const UnbookSuccess('Successfully unbooked the slot')); // Emit success state
        } else {
          emit(const UnbookError('Failed to unbook slot', errorLoading: true)); // Emit error state
        }
      } else {
        emit(const UnbookError('Failed to unbook slot', errorLoading: true)); // Emit error if empty response
      }
    } catch (e) {
      emit(UnbookError(e.toString(), errorLoading: true)); // Emit error state on exception
    }
  }
}
