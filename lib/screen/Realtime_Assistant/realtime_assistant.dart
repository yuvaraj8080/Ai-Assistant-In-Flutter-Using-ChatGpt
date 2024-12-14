import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class RealtimeAssistantScreen extends StatefulWidget {
  const RealtimeAssistantScreen({super.key});

  @override
  State<RealtimeAssistantScreen> createState() => _RealtimeAssistantScreenState();
}

class _RealtimeAssistantScreenState extends State<RealtimeAssistantScreen> {

  TextEditingController inputString = TextEditingController();
  final SpeechToText speechToTextInstance = SpeechToText();
  String recordedAudioString = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSpeechToText();
  }

  //// SPEECH TO TEXT CONVERT METHOD
  void initializeSpeechToText()async{
    await speechToTextInstance.initialize();
    setState(() {

    });
  }

  startListeningNow()async{
    FocusScope.of(context).unfocus();
    await speechToTextInstance.listen(onResult:onSpeechToTextResult);
    setState(() {

    });
  }

  void stopListeningNow()async{
    await speechToTextInstance.stop();
  }

 void onSpeechToTextResult(SpeechRecognitionResult recognitionResult){
    recordedAudioString = recognitionResult.recognizedWords;
    print("*******************************************");

    print(recordedAudioString);
 }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(title:Text("Voice Assistant")),

      floatingActionButton:FloatingActionButton(
        backgroundColor:Colors.white,
        onPressed:(){

        },
        child:Icon(Icons.record_voice_over_outlined),
      ),

      body:SingleChildScrollView(
        child:Padding(
          padding:EdgeInsets.all(10),
          child:Column(children: [

            ///// AI VOICE ASSINSTANT IMAGE HARE
            InkWell(
              onTap:(){
                speechToTextInstance.isListening
                    ? stopListeningNow()
                    : startListeningNow();
              },
                child: speechToTextInstance.isListening
                    ? Lottie.asset('assets/lottie/voice_Assistant.json')
                    : Lottie.asset('assets/lottie/voice_Assistant.json')
            ),

            SizedBox(height:10),

            //// TEXT FILED WITH  BUTTON
            Row(
              children: [
              //// TEXT FIELD HARE
              Expanded(
                child:TextFormField(
                  // controller:,
                  decoration:InputDecoration(
                     border:OutlineInputBorder(),
                    labelText:"How can i help today",
                  )
                )
              ),

                const SizedBox(width:5),

                InkWell(
                  onTap:(){},
                  child:AnimatedContainer(
                    padding:EdgeInsets.all(10),
                      decoration:BoxDecoration(shape:BoxShape.rectangle),
                    duration:const Duration(microseconds:1000),
                    curve:Curves.bounceInOut,
                    child:Icon(Icons.send),
                  )
                )

            ],)



            ///
          ],),
        )
      ),
    );
  }
}
