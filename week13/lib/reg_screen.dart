import 'package:flutter/material.dart';
import 'package:week13/login_screen.dart';
import 'package:week13/shared.dart';
import 'main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RegistrationScreen extends StatelessWidget {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 16.0),
            buildTextfield(text: 'Name', controller: _nameController, obscureText: false),
            const SizedBox(height: 16),
            buildTextfield(text: 'Username', controller: _usernameController, obscureText: false),
            const SizedBox(height: 16),
            buildTextfield(text: 'Email', controller: _emailController, obscureText: false),
            const SizedBox(height: 16),
            buildTextfield(text: 'Password', controller: _passwordController, obscureText: true),
            const SizedBox(height: 25.0,),
             buildElevatedButton(
              text: 'Register',
              onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                      _usernameController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                        _saveData();

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen())
                    );
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Please fill all fields'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        }
                    );
                  }
                },
              ),
          ],
            ),
        ),
      ),
    );
  }

  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('name', _nameController.text);
    prefs.setString('username', _usernameController.text);
    prefs.setString('email', _emailController.text);
    prefs.setString('password', _passwordController.text);
  }
  
}

