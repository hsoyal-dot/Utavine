import 'package:flutter/material.dart';

class SongListWidget extends StatelessWidget {
  final List<String> songs;

  const SongListWidget({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (_, index) => ListTile(
        leading: const Icon(Icons.music_note),
        title: Text(songs[index]),
      ),
    );
  }
}