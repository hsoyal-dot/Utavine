import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utavine/presentation/vine_sense/bloc/vine_sense_cubit.dart';
import 'package:utavine/presentation/vine_sense/bloc/vine_sense_state.dart';

class VineSenseScreen extends StatelessWidget {
  const VineSenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VineSenseCubit()..fetchSongsFromMood(),
      child: Scaffold(
        appBar: AppBar(title: const Text('VineSense')),
        body: BlocBuilder<VineSenseCubit, VineSenseState>(
          builder: (context, state) {
            if (state is VineSenseLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VineSenseLoaded) {
              return ListView.builder(
                itemCount: state.songs.length,
                itemBuilder: (context, index) {
                  final song = state.songs[index];
                  return ListTile(
                    leading: Image.network(song.albumImage, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(song.name),
                    subtitle: Text(song.artists),
                  );
                },
              );
            } else if (state is VineSenseError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}