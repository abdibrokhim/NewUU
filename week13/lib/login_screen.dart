import 'package:flutter/material.dart';
import 'package:week13/shared.dart';
import 'reg_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_screen.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 100,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    buildTextfield(text: 'Username', controller: _usernameController, obscureText: false),
                    const SizedBox(height: 16),
                    buildTextfield(text: 'Password', controller: _passwordController, obscureText: true),
                    const SizedBox(height: 50),
                    buildElevatedButton(text: 'Login', onPressed: () async {
                      await _checkLogin(context);
                    }),
                    const SizedBox(height: 20),
                    buildElevatedButton(text: 'Register', onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegistrationScreen())
                      );
                    }),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkLogin(BuildContext context) async {
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
          var exists = await _getData(context);
          if (exists) {

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen())
      );
          } else {
            showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Username or password is incorrect'),
              actions: [
                buildButton(text: 'OK', onPressed: () {
                  Navigator.pop(context);
                }),
              ],
            );
          }
      );
          }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Please enter your username'),
              actions: [
                buildButton(text: 'OK', onPressed: () {
                  Navigator.pop(context);
                }),
              ],
            );
          }
      );
    }
  }

  Future<bool> _getData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    if (_usernameController.text == username &&
        _passwordController.text == password) {
          return true;
    } else {
      return false;
    }
  }
}