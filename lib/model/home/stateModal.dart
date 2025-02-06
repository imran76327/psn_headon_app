// state_modal.dart
class StateModal {
  final String stateId; // or int, depending on your API structure
  final String stateName;

  StateModal({required this.stateId, required this.stateName});

  // Factory method to create a StateModal from JSON
  factory StateModal.fromJson(Map<String, dynamic> json) {
    return StateModal(
      stateId: json['state_id'].toString(),
      stateName: json['state_name'].toString(),
    );
  }


  // This method returns a list of StateModal if needed
  static List<StateModal> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => StateModal.fromJson(json)).toList();
  }

  // This method returns the state name
  String getStateName() {
    return stateName; // Correctly returns the state name
  }
}
