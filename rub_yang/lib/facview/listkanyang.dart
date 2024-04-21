import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListKanyang extends StatefulWidget {
  @override
  _ListKanYangState createState() => _ListKanYangState();
}

class _ListKanYangState extends State<ListKanyang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("การยางแต่ละอำเภอสุราษฎร์"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("kanyang").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((kanyangDocument) {
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
                        " ${kanyangDocument["Name"]}",
                        style: TextStyle(
                          color: Colors.brown[800],
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                          ),
                      ),
                      
                      Text(
                        "ถนน: ${kanyangDocument["Road"]}",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "ตำบล: ${kanyangDocument["Subdistrict"]}",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "เบอร์ติดต่อ: ${kanyangDocument["TelNum"]}",
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

