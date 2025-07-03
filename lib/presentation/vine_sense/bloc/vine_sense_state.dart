import 'package:utavine/data/models/tracks_data/spotify_song.dart';

abstract class VineSenseState {}

class VineSenseInitial extends VineSenseState {}

class VineSenseLoading extends VineSenseState {}

class VineSenseLoaded extends VineSenseState {
  final double? heartRate;
  final List<String> keywords;
  final List<SpotifySong> songs;

  VineSenseLoaded({
    required this.heartRate,
    required this.keywords,
    required this.songs,
  });
}

class VineSenseError extends VineSenseState {
  final String message;
  VineSenseError(this.message);
}
