import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http; // Use http package
import '../screen/feature/OnlineCourse/Model/CourseModel.dart';
import '../helper/global.dart';

class ApiService {
  // Get answer from Google Gemini AI
  static Future<String> getAnswer(String question) async {
    try {

      final model = GenerativeModel(
        model: 'gemini-2.0-flash-exp',
        apiKey: geminiKey,
      );

      final content = [Content.text(question)];
      final res = await model.generateContent(content);

      return res.text ?? 'No response from AI';
    } catch (e) {
      log('Error in getAnswer: $e');
      return 'Something went wrong (Try again later)';
    }
  }


  static Future<String> getLLamaResponse(String userMessage) async {
    try {
      final url = Uri.parse("https://api.llama-api.com/v1/chat/completions");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $llamaAPITocken',
        },
        body: jsonEncode({
          'model': 'llama3.1-70b',
          'messages': [
            {'role': 'system', 'content': 'Assistant is a large language model trained by OpenAI.'},
            {'role': 'user', 'content': userMessage},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['choices'] != null && jsonResponse['choices'].isNotEmpty) {
          final messageContent = jsonResponse['choices'][0]['message']['content'];
          print(messageContent.toString());
          return messageContent;
        } else {
          return 'No response from AI';
        }
      } else {
        return 'Error: ${response.statusCode}';
      }
    } on TimeoutException catch (e) {
      debugPrint('Timeout in getLLamaResponse: $e');
      return 'Request timed out. Please try again later.';
    } catch (e) {
      debugPrint('Error in getLLamaResponse: $e');
      return 'Something went wrong. Please try again later.';
    }
  }

  // Fetch courses from the AI response
  Future<List<CourseModel>> fetchCourses(String input) async {
    try {
      // Get the response from the AI model
      final response = await getAnswer(input);

      // Clean the response
      String cleanedResponse = response.replaceAll(RegExp(r'```json|```'), '').trim();

      // Parse the response as JSON
      List<dynamic> jsonData = json.decode(cleanedResponse);

      // Map the JSON data to a list of CourseModel
      return jsonData.map((course) => CourseModel.fromJson(course)).toList();
    } catch (e) {
      log('Error fetching courses: $e');
      throw Exception('Failed to load courses: $e');
    }
  }
}