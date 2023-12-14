import 'package:flutter/material.dart';
import 'package:lab_9/db_helper.dart';

class Profile extends StatelessWidget {
  final User user;
  
  const Profile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'),),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            Text('Username: ${user.username}'),
            const SizedBox(height: 20,),
            Text('Password: ${user.password}'),
            const SizedBox(height: 20,),
            Text('Phone: ${user.phone}'),
            const SizedBox(height: 20,),
            Text('Email: ${user.email}'),
            const SizedBox(height: 20,),
            Text('Address: ${user.address}'),
            const SizedBox(height: 20,),
          ],)
      ),
    );
  }
}