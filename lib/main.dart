import 'package:flutter/material.dart';
import 'widgets/banner_slider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const Scaffold(
        // appBar: AppBar(),
        body: SafeArea(
          child: BannerSlider()
        ),
      ),
    );
  }
}
