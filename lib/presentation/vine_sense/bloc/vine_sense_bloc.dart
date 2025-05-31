import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utavine/presentation/vine_sense/bloc/vine_sense_event.dart';
import 'package:utavine/presentation/vine_sense/bloc/vine_sense_state.dart';

class VineSenseBloc extends Bloc<VineSenseEvent, VineSenseState> {
  VineSenseBloc() : super(VineSenseInitialState()) {
    on<FetchStressLevelEvent>((event, emit) async {
      emit(VineSenseLoadingState());

      try {
        final stressLevel = await _getMockStressLevel();
        final keywords = await _getMoodKeywordsFromGemini(stressLevel);
        final songs = await _fetchSongsFromKeywords(keywords);

        emit(VineSenseLoadedState(stressLevel, keywords, songs: songs));
      } catch (e) {
        emit(VineSenseErrorState("Failed to load mood music: $e"));
      }
    });
  }
}

Future<double> _getMockStressLevel() async {
  await Future.delayed(Duration(seconds: 2));
  return 0.7; //mock
}

Future<List<String>> _getMoodKeywordsFromGemini(double stress) async {
  if (stress >= 0.7) {
    return ["soothing", "calm"];
  }
  if (stress >= 0.4) {
    return ["happy", "chill"];
  }
  return ["energetic", "upbeat"];
}

Future<List<String>> _fetchSongsFromKeywords(List<String> keywords) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return ["Sample Song 1", "Sample Song 2", "Sample Song 3"];
}
