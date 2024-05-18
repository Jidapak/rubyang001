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
        stream: FirebaseFirestore.instance.collection("prices").snapshots(),
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
                String name_store = storeDocument["name_store"];
                // Convert timestamp to DateTime
                Timestamp timestamp = storeDocument["today_date"];
                DateTime dateTime = timestamp.toDate();
                // Format DateTime to day/month/year
                String formattedDate =
                    "${dateTime.day}/${dateTime.month}/${dateTime.year}";
                return GestureDetector(
                  onTap: () {
                    if (name_store == name_store) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NameStore(selectedStoreName: name_store),
                          ));
                    }
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
                              SizedBox(width: 5),
                              Text(
                                "อำเภอ ${storeDocument["district"]}",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.brown[900]),
                              ),
                              SizedBox(width: 30),
                              Icon(
                                Icons.date_range,
                                color: Colors.brown[900],
                                size: 20,
                              ),
                              Text(
                                "วันที่ $formattedDate",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.brown[900]),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "ชื่อร้าน ${storeDocument["name_store"]}",
                            style: TextStyle(
                                    fontSize: 16, color: Colors.brown[900]),
                              ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "เบอร์ติดต่อร้าน${storeDocument["telnum"]}",
                            style: TextStyle(fontSize: 16, color: Colors.brown[900]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}