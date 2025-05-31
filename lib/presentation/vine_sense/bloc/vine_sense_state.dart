abstract class VineSenseState {}

class VineSenseInitialState extends VineSenseState {}

class VineSenseLoadingState extends VineSenseState {}

class VineSenseLoadedState extends VineSenseState {
  final double stressLevel;
  final List<String> songs;
  final List<String> keywords;

  VineSenseLoadedState(this.stressLevel, this.keywords, {required this.songs});
}

class VineSenseErrorState extends VineSenseState {
  final String message;

  VineSenseErrorState(this.message);
}
