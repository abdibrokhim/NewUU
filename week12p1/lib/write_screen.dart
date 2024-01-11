import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class WriteScreen extends StatefulWidget {
  
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}



class _WriteScreenState extends State<WriteScreen> {

  final _textController = TextEditingController();

  void _saveReadingToFirestore(String reading) {
  var db = FirebaseFirestore.instance;
  db.collection('idea').add({'reading': reading});
  
  _showSnackbar();

  }

  void _showSnackbar() {
      ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Reading saved'),
      duration: const Duration(seconds: 1),
    ),
  );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Add Reading"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Reading here',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveReadingToFirestore(_textController.text);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
