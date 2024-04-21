import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WriteStore extends StatefulWidget {
  @override
  _WriteStoreState createState() => _WriteStoreState();
}

class _WriteStoreState extends State<WriteStore> {
  final database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    final dailyStoreRef = database.child('detailstore');

    return Scaffold(
      appBar: AppBar(
        title: Text('Write detail'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    await dailyStoreRef.set({
                      "description": 'ร้านเล็กอิน',
                      'price': '55'
                    });
                    print("Data uploaded successfully!");
                  } catch (e) {
                    print('Error: $e');
                  }
                },
                child: Text('Press to upload'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
