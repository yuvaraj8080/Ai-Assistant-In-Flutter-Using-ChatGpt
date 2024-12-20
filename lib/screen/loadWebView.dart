import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadWebViewScreen extends StatefulWidget {
  const LoadWebViewScreen({super.key});

  @override
  State<LoadWebViewScreen> createState() => _LoadWebViewScreenState();
}

class _LoadWebViewScreenState extends State<LoadWebViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    requestMicrophonePermission(); // Request microphone permission
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://aistudio.google.com/app/live"));
  }

  Future<void> requestMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vision AI'),
      ),
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}