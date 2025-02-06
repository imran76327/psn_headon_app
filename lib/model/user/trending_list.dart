import '../music_model.dart';

class TrendingList {
  final List<MusicModel> music;
  final DateTime from_date;
  final DateTime to_date;

  TrendingList({
    required this.music,
    required this.from_date,
    required this.to_date,
  });

  factory TrendingList.fromJson(json) {
    return TrendingList(
      music: json['music'],
      from_date: json['from_date'],
      to_date: json['to_date'],
    );
  }
}
