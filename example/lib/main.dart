import 'package:flutter/material.dart';
import 'package:flutter_rtsp_client/flutter_rtsp_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late RtspPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = RtspPlayerController.network('rtsp://192.168.8.4');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: FlutterRtspPlayer(
            controller: controller,
            aspectRatio: 16 / 9,
          ),
        ),
      ),
    );
  }
}
