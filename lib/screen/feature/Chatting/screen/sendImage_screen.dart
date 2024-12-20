import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controller/sendImageController.dart';



class SendImageScreen extends StatelessWidget {
  const SendImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sendImageController = Get.put(SendImageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Image Prompt!'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image

            Container(
              height: 400,
              color: Colors.grey[200],
              child: sendImageController.image == null
                  ? const Center(
                child: Text(
                  'No Image Selected',
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : Image.file(
                File(sendImageController.image!.path),
                fit: BoxFit.cover,
              ),
            ),


            // Pick and Remove image buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CupertinoButton.filled(
                      padding: EdgeInsets.zero,
                      onPressed:()=> sendImageController.pickImage(),
                      child: const Text('Pick Image'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CupertinoButton.filled(
                      padding: EdgeInsets.zero,
                      onPressed:()=> sendImageController.removeImage(),
                      child: const Text('Remove Image'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Text Field
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: sendImageController.promptController,
                decoration: const InputDecoration(
                  hintText: 'Write something about the image...',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
              ),
            ),
            const SizedBox(height:20),
            // Send Message Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:ElevatedButton(
                child:Text("Send Image"),
                onPressed:(){
                  sendImageController.sendMessage();
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}
