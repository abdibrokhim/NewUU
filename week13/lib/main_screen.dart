import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week13/login_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = '/main';

  @override
  MainScreenState createState() => MainScreenState();

}

class MainScreenState extends State<MainScreen> {

  String _username = '';
  String _email = '';
  String _name = '';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = (prefs.getString('username') ?? '');
      _email = (prefs.getString('email') ?? '');
      _name = (prefs.getString('name') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Screen'), 
      leading: Builder(builder: 
      (BuildContext context) {
        return SizedBox();
      },
      ),),
      body: SingleChildScrollView(
        child:
        Center(child:
      Column(children: [
        SizedBox(height: 16,),
        Text('Name: $_name'),
        SizedBox(height: 16,),
        Text('Username: $_username'),
        SizedBox(height: 16,),
        Text('Email: $_email'),
      ],)
      )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
                          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen())
                    );
        },
        child: const Icon(Icons.logout),
        backgroundColor: Colors.black,
      ),
    );
  }
}