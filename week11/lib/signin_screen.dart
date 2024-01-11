import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:week11/custom_error_widget.dart';
import 'package:week11/home_screen.dart';
import 'package:week11/signup_screen.dart';


class SignInScreen extends StatefulWidget {
  static String routeName = "/signIn";
  
  const SignInScreen({
    Key? key, 
  }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _performLogin() async {
    if (_usernameController.text.isEmpty) {
      addError(error: 'Email is required');
      return;
    }
    if (_passwordController.text.isEmpty) {
      addError(error: 'Password is required');
      return;
    }

    User user = await firebaseLogin();

    if (user != null) {
      _navigateToHomeScreen(user);
    }

  }

  void _navigateToHomeScreen(User user) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
  }

  Future<User> firebaseLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text
      );
      print(userCredential);
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        addError(error: 'No user found for that email.');
        return Future.error('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        addError(error: 'Wrong password provided for that user.');
        return Future.error('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
    return Future.error('Unknown error');
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

  bool showOnce = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: SingleChildScrollView(
            child: Column(
              children: [
                      const SizedBox(height: 20,),
                                  if (errors.isNotEmpty)
                      CustomErrorWidget(
                        errors: errors
                      ),
                      const SizedBox(height: 20,),
                TextField(
                  controller: _usernameController,
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
                  onPressed: _performLogin,
                  child: const Text('Sign In'),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('I don\'t have an account, lemme '),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('I forgot my password, lemme '),
                    TextButton(
                      onPressed: () {
                        // TODO: implement forgot password
                        print('not implemented yet');
                      },
                      child: const Text('Reset Password'),
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
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}