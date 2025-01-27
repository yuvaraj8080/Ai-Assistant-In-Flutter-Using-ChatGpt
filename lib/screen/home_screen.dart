import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'feature/Chatting/screen/chatbot_feature.dart';
import 'feature/OnlineCourse/Url_Launcher_Controller.dart';
import '../helper/global.dart';
import '../helper/pref.dart';
import 'feature/OnlineCourse/cpourse_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _isDarkMode = Get.isDarkMode.obs;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Pref.showOnboarding = false;
  }

  @override
  Widget build(BuildContext context) {
    UrlController urlController = Get.put(UrlController());
    mq = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          IconButton(
              padding: const EdgeInsets.only(right: 10),
              onPressed: () {
                Get.changeThemeMode(
                    _isDarkMode.value ? ThemeMode.light : ThemeMode.dark);

                _isDarkMode.value = !_isDarkMode.value;
                Pref.isDarkMode = _isDarkMode.value;
              },
              icon: Obx(() => Icon(
                  _isDarkMode.value
                      ? Icons.brightness_2_rounded
                      : Icons.brightness_5_rounded,
                  size: 26)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => const ChatBotFeature());
              },
              child: Container(
                width: double.infinity,
                height: 50,
                color: Colors.green,
                child: Center(child: Text("Chatting Screen")),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Get.to(() => CourseListView());
              },
              child: Container(
                width: double.infinity,
                height: 50,
                color: Colors.green,
                child: Center(child: Text("Online Course")),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                urlController.launchLink(Uri.parse("https://aistudio.google.com/live"));
              },
              child: Container(
                width: double.infinity,
                height: 50,
                color: Colors.green,
                child: Center(child: Text("Ai Launcher")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}