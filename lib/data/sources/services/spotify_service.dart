import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:utavine/data/models/tracks_data/spotify_song.dart';

class SpotifyService {
  static final port = dotenv.env['PORT'];
  static final String _baseUrl = 'http://localhost:3000';

  static Future<List<SpotifySong>> searchSongs(String keyword) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$keyword'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((song) => SpotifySong.fromJson(song)).toList();
    } else {
      throw Exception('Failed to load songs from Spotify');
    }
  }
} 