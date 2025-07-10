import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final class GeminiService {
  static final _apiKey = dotenv.env['GEMINI_API_KEY'];
  static final _baseUrl = dotenv.env['GEMINI_URL'];

  static Future<List<String>> getMoodKeywords(double? heartRate) async {
    final url = '$_baseUrl?key=$_apiKey';
    final promptTemplate = dotenv.env['GEMINI_PROMPT'];

    if (promptTemplate == null) {
      throw Exception("Missing Gemini prompt template.");
    }
    final prompt = promptTemplate.replaceAll(
      '{{heartRate}}',
      heartRate.toString(),
    );
    print(prompt);

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt},
            ],
          },
        ],
      }),
    );

    print('Gemini response: ${response.body}');

    final data = jsonDecode(response.body);

    final output =
        data['candidates'][0]['content']['parts'][0]['text'] as String;
    final keywords = output.split(',').map((k) => k.trim()).toList();
    return keywords;
  }
}