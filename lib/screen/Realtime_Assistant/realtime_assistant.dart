import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
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
        title: Text('Vision AI'),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
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
                SizedBox(height: 80),
                // HARE IS THE HELP TEXT CONTAINER
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        Text("Hello!", style: TextStyle(color: Colors.white, fontSize: 24),),
                        Text("What can I do for you?", style: TextStyle(color: Colors.white, fontSize: 18),),
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ZoomIn(
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () async {
            if (controller.isListening) {
              await controller.stopListening();
              final speech = await controller.getAnswerFromGemini(controller.lastWords.value);
              controller.generatedContent.value = speech;
              await controller.systemSpeak(speech);
            } else {
              await controller.startListening(controller.onSpeechResult);
            }
          },
          child: Icon(
            controller.isListening ? Icons.stop : Icons.mic,
          ),
        ),
      ),
    );
  }
}