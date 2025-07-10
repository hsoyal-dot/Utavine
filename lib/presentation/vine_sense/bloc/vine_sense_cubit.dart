import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utavine/data/models/tracks_data/spotify_song.dart';
import 'package:utavine/data/sources/services/gemini_service.dart';

import 'package:utavine/data/sources/services/spotify_service.dart';
import 'package:utavine/data/sources/services/supabase_service.dart';
import 'package:utavine/presentation/vine_sense/bloc/vine_sense_state.dart';

class VineSenseCubit extends Cubit<VineSenseState> {
  VineSenseCubit() : super(VineSenseInitial());

  Future<void> fetchSongsFromMood() async {
    emit(VineSenseLoading());
    try {
      final heartRate = await SupabaseService.fetchHeartRate();
      final moodKeywords = await GeminiService.getMoodKeywords(heartRate);
      final allSongs = <SpotifySong>[];
      for (var keyword in moodKeywords) {
        final songs = await SpotifyService.searchSongs(keyword);
        allSongs.addAll(songs);
      }
      emit(
        VineSenseLoaded(heartRate: heartRate, keywords: moodKeywords, songs: allSongs),
      );
    } catch (e) {
      emit(VineSenseError(e.toString()));
    }
  }
}