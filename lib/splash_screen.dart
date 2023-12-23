import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return SizedBox();
        }),
        title: const Text("Welcome"),
      ),
      body: const Center(
        child: Text("This is a quick tutorial."),
      ),
    );
  }
}
