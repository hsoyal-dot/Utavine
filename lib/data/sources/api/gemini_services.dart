import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final class GeminiService {
  static final _apiKey = dotenv.env['GEMINI_API_KEY'];
  static final _baseUrl = dotenv.env['GEMINI_URL'];

  static Future<List<String>> getMoodKeywords(double stress) async {
    final url = '$_baseUrl?key=$_apiKey';
    final promptTemplate = dotenv.env['GEMINI_PROMPT'];
    // checking for the prompt was necessary just bcz null errors
    if (promptTemplate == null) {
      throw Exception("Missing Gemini prompt template.");
    }
    final prompt = promptTemplate.replaceAll('{{stress}}', stress.toString());

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

    // print('Gemini response: ${response.body}'); 

    final data = jsonDecode(response.body);

    final output =
        data['candidates'][0]['content']['parts'][0]['text'] as String;
    final keywords = output.split(',').map((k) => k.trim()).toList();
    return keywords;
  }
}
