import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  
  final User user;

  const HomeScreen({
    Key? key,
    required this.user,
    }) : super(key: key);

  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome!"),
      ),
      body: Center(
        child: Text("Welcome to the home screen, dear ${user.email}"),
      ),
    );
  }
}