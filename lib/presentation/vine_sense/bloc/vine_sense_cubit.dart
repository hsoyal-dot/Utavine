import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utavine/data/models/tracks_data/spotify_song.dart';

import 'package:utavine/data/sources/api/spotify_service.dart';
import 'package:utavine/presentation/vine_sense/bloc/vine_sense_state.dart';



class VineSenseCubit extends Cubit<VineSenseState> {
  VineSenseCubit() : super(VineSenseInitial());

  Future<void> fetchSongsFromMood(List<String> keywords) async {
    emit(VineSenseLoading());
    try {
      final allSongs = <SpotifySong>[];
      for (var keyword in keywords) {
        final songs = await SpotifyService.searchSongs(keyword);
        allSongs.addAll(songs);
      }
      emit(VineSenseLoaded(
  stressLevel: 0.3,
  keywords: keywords,
  songs: allSongs,
));
    } catch (e) {
      emit(VineSenseError(e.toString()));
    }
  }
}
