import 'dart:developer';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../helper/global.dart';



class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final SpeechToText speechToText = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  bool isListening = false;
  RxString lastWords = ''.obs;
  RxString generatedContent = ''.obs;

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
  }

  Future<void> startListening(Function(SpeechRecognitionResult) onSpeechResult) async {
    if (await speechToText.hasPermission) {
      isListening = true;
      await speechToText.listen(onResult: (SpeechRecognitionResult result) async {
        onSpeechResult(result);
        if (result.finalResult) {
          await stopListening();
          String response = await getAnswerFromGemini(lastWords.value);
          generatedContent.value = response;
          await systemSpeak();
        }
      });
    }
  }

  Future<void> stopListening() async {
    if (isListening) {
      isListening = false;
      await speechToText.stop();
    }
  }

  Future<void> systemSpeak() async {
    await flutterTts.speak(generatedContent.value);
  }


  Future<void> stopSpeaking() async {
    await flutterTts.stop();
    generatedContent.value = "";
  }

  Future<String> getAnswerFromGemini(String question) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: geminiKey,
      );

      final content = [Content.text(question)];
      final res = await model.generateContent(content, safetySettings: [
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
      ]);

      log('Response: ${res.text}');
      return res.text ?? 'No response from Gemini API';
    } catch (e) {
      log('Error fetching response: $e');
      return 'Something went wrong. Please try again later.';
    }
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    lastWords.value = result.recognizedWords;
  }
}

