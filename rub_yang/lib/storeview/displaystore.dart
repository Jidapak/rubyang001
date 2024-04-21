import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:rub_yang/Pages/timeslot.dart';
import 'package:rub_yang/storeview/namestore.dart';

// Show location District
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
          "อำเภอของร้านรับซื้อ",
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("store").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            width: double.infinity,
            child: ListView(
              children: snapshot.data!.docs.map((storeDocument) {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("prices").snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> pricesSnapshot) {
                    if (!pricesSnapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NameStore()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.brown,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.brown[900],
                                    size: 20,
                                  ),
                                  SizedBox(width: 5), // Add space between icon and text
                                  Text(
                                    "อำเภอ: ${storeDocument["district"]}",
                                    style: TextStyle(color: Colors.brown[900]),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ตำบล: ${storeDocument["subdistrict"]}",
                                style: TextStyle(color: Colors.brown[900]),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}