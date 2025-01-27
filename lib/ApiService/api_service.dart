import 'dart:convert';
import 'dart:developer';
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