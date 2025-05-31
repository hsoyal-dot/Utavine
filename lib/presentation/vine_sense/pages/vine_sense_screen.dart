import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utavine/common/widgets/appbar/custom_app_bar.dart';
import 'package:utavine/presentation/vine_sense/bloc/vine_sense_bloc.dart';
import 'package:utavine/presentation/vine_sense/bloc/vine_sense_event.dart';
import 'package:utavine/presentation/vine_sense/bloc/vine_sense_state.dart';
import 'package:utavine/presentation/vine_sense/widgets/song_list_widget.dart';

class VineSenseScreen extends StatelessWidget {
  const VineSenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VineSenseBloc()..add(FetchStressLevelEvent()),
      child: Scaffold(
        appBar: CustomAppBar(title: Text(
          'Vine Sense',
          textAlign: TextAlign.left,
          )),
        body: BlocBuilder<VineSenseBloc, VineSenseState>(
          builder: (context, state) {
                if (state is VineSenseLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is VineSenseLoadedState) {
                  return Column(
                    children: [
                      Text('Stress Level: ${state.stressLevel}'),
                      Text('Mood Keywords: ${state.keywords.join(', ')}'),
                      Expanded(child: SongListWidget(songs: state.songs)),
                    ],
                  );
                } else if (state is VineSenseErrorState) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(
                    child: Text(
                      'Welcome to Vine Sense! Please wait while we load your data.',
                    ),
                  );
                }
          },
        ),
      ),
    );
  }
}
