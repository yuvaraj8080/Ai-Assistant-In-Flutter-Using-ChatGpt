import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'Home_Controller.dart';


class RealtimeAssistantScreen extends StatelessWidget {
  final HomeController controller = HomeController();

  RealtimeAssistantScreen({super.key}) {
    controller.initSpeechToText();
    controller.initTextToSpeech();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Vision AI',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        leading: const Icon(Icons.menu),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue, // Start color
              Colors.purple, // End color
            ],
            begin: Alignment.topLeft, // Start point of the gradient
            end: Alignment.bottomRight, // End point of the gradient
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Help Text Container
                Container(
                  child: Center(
                    child: Column(
                      children: const [
                        Text(
                          "Hello!",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        Text(
                          "What can I do for you?",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                // Lottie Animation
                Container(
                  child: Lottie.asset("assets/lottie/FlowAnimtion3.json", width: 280),
                ),
                const SizedBox(height: 100),
                // Gemini Voice Lottie Animation
                InkWell(
                  onTap: () async {
                    if (!controller.isListening) {
                      await controller.startListening(controller.onSpeechResult);
                    }
                  },
                  child: Container(
                    child: Lottie.asset("assets/lottie/GeminiVoice.json", width: 200),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.record_voice_over_rounded, size: 30),
        onPressed: () async {
          await controller.stopSpeaking();
        },
      ),
    );
  }
}
