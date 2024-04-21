import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListFactory extends StatefulWidget {
  @override
  _ListFactoryState createState() => _ListFactoryState();
}

class _ListFactoryState extends State<ListFactory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายชื่อโรงงาน"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("factory").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((factoryDocument) {
              return GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => NameStore()),
                  // );
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
                       Text(
                        "ชื่อโรงงาน: ${factoryDocument["FactoryName"]}",
                        style: TextStyle(
                          color: Colors.brown[800],
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                          ),
                      ),
                      Text(
                        "เลขที่: ${factoryDocument["no"]}",
                        style:TextStyle(color: Colors.black),
                      ),
                      Text(
                        "Road: ${factoryDocument["Road"]}",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "District: ${factoryDocument["District"]}",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "Sub-district: ${factoryDocument["Sub-district"]}",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "เบอร์ติดต่อ: ${factoryDocument["TelNum"]}",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

