import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hw4/db_helper.dart';
import 'package:hw4/second_screen.dart';
import 'package:hw4/splash_screen.dart';
import 'package:hw4/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class MainScreen extends StatefulWidget {
  
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('first_time') ?? true;

    if (isFirstTime) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SplashScreen()),
      );
      await prefs.setBool('first_time', false);
    }
  }
  
  get url_ => 'https://randomuser.me/api/?results=20';

    List<User> users = [];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const UserListScreen()),
                );
              },
              icon: const Icon(Icons.list),
            ),
          ],
          title: const Text('List of something'),
        ),
        body: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index){
              final user = users[index];
              final email = user.email;
              final gender = user.gender;
              return ListTile(
                title: Text(email),
                subtitle: Text(gender),
                onTap: () => saveUserToDatabase(user),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: fetch,
          ),
        );
    }

    void fetch() async {
      try {
        final uri = Uri.parse(url_);
        final response = await http.get(uri);

        if (response.statusCode == 200) {
          final body = response.body;
          final jsonData = jsonDecode(body);

setState(() {
  users = (jsonData['results'] as List)
      .map((userJson) => User.fromJson(userJson))
      .toList();
});

        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      } catch (e) {
        print('Error fetching users: $e');
      }
    }

    void saveUserToDatabase(User user) async {
      DBHelper dbHelper = DBHelper();
      await dbHelper.saveUser(user);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User ${user.email} saved to database"),
        ),
      );
    }
  }