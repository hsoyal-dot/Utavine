import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utavine/data/models/tracks_data/spotify_song.dart';
import 'package:utavine/data/sources/api/gemini_services.dart';
import 'package:utavine/data/sources/api/spotify_service.dart';
import 'package:utavine/presentation/vine_sense/bloc/vine_sense_event.dart';
import 'package:utavine/presentation/vine_sense/bloc/vine_sense_state.dart';

class VineSenseBloc extends Bloc<VineSenseEvent, VineSenseState> {
  VineSenseBloc() : super(VineSenseInitial()) {
    on<FetchStressLevelEvent>((event, emit) async {
      emit(VineSenseLoading());

      try {
        final stressLevel = await _getMockStressLevel();
        final keywords = await _getMoodKeywordsFromGemini(stressLevel);
        final songs = await _fetchSongsFromKeywords(keywords);

        emit(VineSenseLoaded(stressLevel: stressLevel, keywords: keywords, songs: songs));
      } catch (e) {
        emit(VineSenseError("Failed to load mood music: $e"));
      }
    });
  }
}

Future<double> _getMockStressLevel() async {
  await Future.delayed(Duration(seconds: 2));
  return 0.2; //mock
}

Future<List<String>> _getMoodKeywordsFromGemini(double stress) async {
  return await GeminiService.getMoodKeywords(stress);
}

Future<List<SpotifySong>> _fetchSongsFromKeywords(List<String> keywords) async {
  final List<SpotifySong> allSongs = [];
  for (final keyword in keywords) {
    final results = await SpotifyService.searchSongs(keyword);
    allSongs.addAll(results);
  }
  return allSongs;
}
