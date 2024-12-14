import 'package:ai_assistant/repository/Chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../../../helper/global.dart';

class SendImageController extends GetxController {
  static SendImageController get instance => Get.find();


  final chatRepository = Get.put(ChatRepository());

  // Variable to hold the selected image
  XFile? image;

  // Observable for loading status
  final isLoading = false.obs;

  // TextEditingController for any text input
  late TextEditingController promptController;

  @override
  void onInit() {
    super.onInit();
    promptController = TextEditingController();
  }

  // Method to pick an image from the gallery
  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(
        maxWidth: 1280,
        maxHeight: 1280,
        imageQuality: 80,
        source: ImageSource.gallery,
        requestFullMetadata: true,
      );

      if (pickedImage != null) {
        // Update the image variable and notify listeners
        image = pickedImage;
        update(); // Notify listeners about the change
      }
    } catch (e) {
      // Handle any errors that occur during image picking
      throw Exception(e.toString());
    }
  }

  // Method to send a message with the selected image
  Future<void> sendMessage() async {

    if (image == null) return;
    // Set loading state to true
    isLoading.value = true;
    try {

     await chatRepository.sendMessage(
          apiKey:geminiKey,
          image: image,
          promptText:promptController.text.trim());

    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Method to remove the selected image
  void removeImage() {
    image = null;
    update(); // Notify listeners about the change
  }
}