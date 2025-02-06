class RespondModel {
  final int id;
  final int confirmation;

  RespondModel({
    required this.id,
    required this.confirmation,
  });

  factory RespondModel.fromJson(Map<String, dynamic> json) {
    return RespondModel(
      id: json['id'],
      confirmation: json['confirmation'],
    );
  }
}
