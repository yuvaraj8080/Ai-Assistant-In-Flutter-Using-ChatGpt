import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/Chatting/screen/chatbot_feature.dart';
import '../screen/Realtime_Assistant/realtime_assistant.dart';
import '../screen/feature/image_feature.dart';
import '../screen/feature/translator_feature.dart';

enum HomeType { aiChatBot, aiImage, aiTranslator, realtimeVoice }

extension MyHomeType on HomeType {
  //title
  String get title => switch (this) {
        HomeType.aiChatBot => 'AI ChatBot',
        HomeType.aiImage => 'AI Image Creator',
        HomeType.aiTranslator => 'Language Translator',
        HomeType.realtimeVoice => 'Voice Assistant',
      };

  //lottie
  String get lottie => switch (this) {
        HomeType.aiChatBot => 'ai_hand_waving.json',
        HomeType.aiImage => 'ai_play.json',
        HomeType.aiTranslator => 'ai_ask_me.json',
        HomeType.realtimeVoice => 'voice_Assistant.json',
      };

  //for alignment
  bool get leftAlign => switch (this) {
        HomeType.aiChatBot => true,
        HomeType.aiImage => false,
        HomeType.aiTranslator => true,
        HomeType.realtimeVoice => false,
      };

  //for padding
  EdgeInsets get padding => switch (this) {
        HomeType.aiChatBot => EdgeInsets.zero,
        HomeType.aiImage => const EdgeInsets.all(20),
        HomeType.aiTranslator => EdgeInsets.zero,
        HomeType.realtimeVoice => const EdgeInsets.all(20),

  };


  //for navigation
  VoidCallback get onTap => switch (this) {
        HomeType.aiChatBot => () => Get.to(() => const ChatBotFeature()),
        HomeType.aiImage => () => Get.to(() => const ImageFeature()),
        HomeType.aiTranslator => () => Get.to(() => const TranslatorFeature()),
        HomeType.realtimeVoice => () => Get.to(() => RealtimeAssistantScreen()),
      };
}
