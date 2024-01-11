import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:week12p1/write_screen.dart';


class ReadScreen extends StatefulWidget {
  
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}



class _ReadScreenState extends State<ReadScreen> {


  List<String> readings = [];

  @override
  void initState() {
    super.initState();
    _getDataFromFirestore();
  }

  void _addReading() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WriteScreen()));
  }

  void _getDataFromFirestore() {
    var db = FirebaseFirestore.instance;
    db.collection('idea').get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          readings.add(doc['reading']);
        });
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Last Readings"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var reading in readings)
              Text(
                reading,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
          ],
        ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReading,
        tooltip: 'Add Yours',
        child: const Icon(Icons.add),
      ),
    );
  }
}
