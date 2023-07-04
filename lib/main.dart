import 'package:flutter/material.dart';

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
      home: Scaffold(
        // appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                // height: MediaQuery.of(context).size.height/5,
                child: PageView.builder(
                  itemCount: 3,
                  controller: PageController(
                    viewportFraction: 0.8,
                    initialPage: 1
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 200,
                      color: Colors.amber,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
