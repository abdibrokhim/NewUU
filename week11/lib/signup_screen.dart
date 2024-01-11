import 'package:flutter/material.dart';
import 'package:week11/custom_error_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignUpScreen extends StatefulWidget {
  static const String routeName = "/signUp";

  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  void _performSignUp() {
        if (_emailController.text.isEmpty) {
      addError(error: 'Email is required');
      return;
    }
    if (_passwordController.text.isEmpty) {
      addError(error: 'Password is required');
      return;
    }
    if (_fullNameController.text.isEmpty) {
      addError(error: 'Full name is required');
      return;
    }
    
  }

  void firebaseSignUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
      );
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        addError(error: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        addError(error: 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }


    List<String> errors = [];

  @override
  void initState() {
    super.initState();

    initErrors();
  }


  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void initErrors() {
    setState(() {
      errors = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context,);
            },
            icon: const Icon(Icons.arrow_back),
          )
        ],
        title: const Text('Sign Up'),
      ),
      body: 
      SingleChildScrollView(
        child: Column(
          children: [
                                  const SizedBox(height: 20,),
                                  if (errors.isNotEmpty)
                      CustomErrorWidget(
                        errors: errors
                      ),
                      const SizedBox(height: 20,),
            TextField(
              controller: _fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: 'Full Name is required');
                }
              },
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: 'Email is required');
                }
              },
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: 'Password is required');
                }
              },
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _performSignUp,
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('I already have an account, lemme '),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context,);
                  },
                  child: const Text('Sign in'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}