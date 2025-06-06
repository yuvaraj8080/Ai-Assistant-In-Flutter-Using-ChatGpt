import 'package:ai_assistant/helper/ad_helper.dart';
import 'package:ai_assistant/model/GeminiChatImageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'Storage_repository.dart';


class ChatRepository extends GetxController{

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  //! This method sends an image alongside the text
  Future sendMessage({
    required String apiKey,
    required XFile? image,
    required String promptText,
  }) async {
    // Define your model
    final textModel = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final imageModel = GenerativeModel(
      model: 'gemini-pro-vision',
      apiKey: apiKey,
    );

    final userId = _auth.currentUser!.uid;
    final sentMessageId = const Uuid().v4();

    GeminiChatMessageModel message = GeminiChatMessageModel(
      id: sentMessageId,
      message: promptText,
      createdAt: DateTime.now(),
      isMine: true,
    );

    if (image != null) {
      // Save image to Firebase Storage and get download url
      final downloadUrl = await StorageRepository().saveImageToStorage(
        image: image,
        messageId: sentMessageId,
      );

      message = message.copyWith(
        imageUrl: downloadUrl,
      );
    }

    // Save Message to Firebase
    await _firestore
        .collection('conversations')
        .doc(userId)
        .collection('messages')
        .doc(sentMessageId)
        .set(message.toMap());

    // Create a response
    GenerateContentResponse response;

    try {
      if (image == null) {
        // Make a text only request to Gemini API
        response = await textModel.generateContent([Content.text(promptText)]);
      } else {
        // convert it to Uint8List
        final imageBytes = await image.readAsBytes();

        // Define your parts
        final prompt = TextPart(promptText);
        final mimeType = image.getImageFileType();
        final imagePart = DataPart(mimeType, imageBytes);

        // Make a mutli-model request to Gemini API
        response = await imageModel.generateContent([
          Content.multi([
            prompt,
            imagePart,
          ])
        ]);
      }

      final responseText = response.text;

      // Save the response in Firebase
      final receivedMessageId = const Uuid().v4();

      final responseMessage = GeminiChatMessageModel(
        id: receivedMessageId,
        message: responseText!,
        createdAt: DateTime.now(),
        isMine: false,
      );

      // Save Message to Firebase
      await _firestore
          .collection('conversations')
          .doc(userId)
          .collection('messages')
          .doc(receivedMessageId)
          .set(responseMessage.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
