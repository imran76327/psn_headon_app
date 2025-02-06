class MusicModel {
  final String name;
  final String imageUrl;
  final String artist;
  final String path;
  final double length;
  late final bool isFav;
  bool isDownloaded;

  MusicModel({
    required this.name,
    required this.imageUrl,
    required this.artist,
    required this.length,
    required this.isFav,
    required this.path,
    this.isDownloaded = false,
  });
}

List<MusicModel> musicList = [
  MusicModel(
      name: "Lose it",
      imageUrl: "assets/images/1.jpg",
      artist: "Flume ft. Vic Mensa",
      length: 345,
      isFav: true,
      path: "audios/9.mp3"),
  MusicModel(
      name: "Helix",
      imageUrl: "assets/images/2.jpg",
      artist: "Flume",
      length: 430,
      isFav: false,
      path: "audios/7.mp3"),
  MusicModel(
      name: "Say It",
      imageUrl: "assets/images/3.jpg",
      artist: "Flume ft. Tove Lo",
      length: 250,
      isFav: false,
      path: "audios/5.mp3"),
  MusicModel(
      name: "Never Be Like You",
      imageUrl: "assets/images/4.jpg",
      artist: "Flume • Kai",
      length: 500,
      isFav: true,
      path: "audios/7.mp3"),
  MusicModel(
      name: "Numb & Getting Colder",
      imageUrl: "assets/images/5.jpg",
      artist: "Flume • KUCKA",
      length: 330,
      isFav: true,
      path: "audios/1.mp3"),
  MusicModel(
      name: "Wall Out",
      imageUrl: "assets/images/6.jpg",
      artist: "Flume",
      length: 250,
      isFav: false,
      path: "audios/2.mp3"),
  MusicModel(
      name: "Pika",
      imageUrl: "assets/images/7.jpg",
      artist: "Flume ft. Tove Lo",
      length: 450,
      isFav: true,
      path: "audios/5.mp3"),
  MusicModel(
      name: "Space Cadet",
      imageUrl: "assets/images/8.jpg",
      artist: "Flume ft. Tove",
      length: 450,
      isFav: true,
      path: "audios/6.mp3"),
  MusicModel(
      name: "Hyperreal",
      imageUrl: "assets/images/9.jpg",
      artist: "Tove Lo",
      length: 450,
      isFav: false,
      path: "audios/7.mp3"),
  MusicModel(
      name: "Smoke & Retribution",
      imageUrl: "assets/images/10.jpg",
      artist: "Flume • KUCKA",
      length: 450,
      isFav: false,
      path: "audios/8.mp3"),
];
