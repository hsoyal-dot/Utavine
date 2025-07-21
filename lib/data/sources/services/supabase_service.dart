import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SupabaseService {
  static final supabaseUrl = dotenv.env['SUPABASE_URL'];
  static final supabaseApiKey = dotenv.env['SUPABASE_API_KEY'];
  static String? get userId => FirebaseAuth.instance.currentUser?.uid;

  static Future<double?> fetchHeartRate() async {
    final uid = userId;
    if (uid == null || supabaseUrl == null || supabaseUrl!.isEmpty) {
      return null;
    }

    final url = Uri.parse(
      "$supabaseUrl/heartbeat_rate?select=*&user_id=eq.$uid&order=timestamp.desc&limit=1",
    );

    final response = await http.get(
      url,
      headers: {
        'apikey': supabaseApiKey ?? '',
        'Authorization': 'Bearer ${supabaseApiKey ?? ''}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final bpm = data[0]['bpm'];
        //just wrote this for debugging purposes
        print("USER ID: $uid");
        print("HEART RATE SENT: $bpm");
        if (bpm is num) {
          return bpm.toDouble();
        }
      }
    } else {
      print('Failed to fetch heart rate: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return null;
  }
}
