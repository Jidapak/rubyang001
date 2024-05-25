import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rub_yang/storeview/namestore.dart';

class DisplayStore extends StatefulWidget {
  @override
  _DisplayStoreState createState() => _DisplayStoreState();
}

class _DisplayStoreState extends State<DisplayStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ร้านรับซื้อยาง",
          style: TextStyle(
            color: Colors.brown,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("storeprofile")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  String nameStore = document["NameStore"]; 
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NameStore(selectedStoreName: nameStore),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ร้านรับซื้อ: ${document["NameStore"]}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'อำเภอ: ${document["District"]}',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'วันที่: ${document["Subdistrict"]}',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'เบอร์โทร: ${document["Teleph"]}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
