import 'dart:convert';
import 'dart:developer';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart';
import 'package:translator_plus/translator_plus.dart';

import '../helper/global.dart';

class ApiService {
  //get answer from google gemini ai
  static Future<String> getAnswer(String question) async {
    try {
      log('api key: $geminiKey');

      final model = GenerativeModel(
        model: 'gemini-2.0-flash-exp',
        apiKey: geminiKey,
      );

      final content = [Content.text(question)];
      final res = await model.generateContent(content);

      log('res: ${res.text}');

      return res.text!;
    } catch (e) {
      log('getAnswerGeminiE: $e');
      return 'Something went wrong (Try again in sometime)';
    }
  }
}
