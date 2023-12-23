import 'package:flutter/material.dart';
import 'package:hw4/db_helper.dart';
import 'package:hw4/user_model.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);
  
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<User?>> _userList;

  @override
  void initState() {
    super.initState();
    _userList = getUsers();
  }

  Future<List<User?>> getUsers() async {
    DBHelper dbHelper = DBHelper();
    return await dbHelper.get_user_list("user.db");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Users"),
      ),
      body: FutureBuilder<List<User?>>(
        future: _userList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            List<User?>? users = snapshot.data;
            return ListView.builder(
              itemCount: users!.length,
              itemBuilder: (context, index) {
                User? user = users[index];
                return ListTile(
                  title: Text(user?.email ?? 'No Email'),
                  subtitle: Text(user?.gender ?? 'No Gender'),
                );
              },
            );
          } else {
            return Center(child: Text("No users found"));
          }
        },
      ),
    );
  }
}
