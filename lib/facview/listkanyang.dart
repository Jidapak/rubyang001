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
        title: Text("การยางแต่ละอำเภอสุราษฎร์",
           style: TextStyle(
              color: Colors.brown,
              fontSize: 20,
              fontWeight: FontWeight.bold,
        ),
      ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("kanyang").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: snapshot.data!.docs.map<Widget>((kanyangDocument) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors
                                          .grey[300]!, // Adjust divider color
                                      width: 1.0, // Adjust divider thickness
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "ชื่อร้าน: ${kanyangDocument["Name"]}",
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 18
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors
                                          .grey[300]!, // Adjust divider color
                                      width: 1.0, // Adjust divider thickness
                                    ),
                                  ),
                                ),
                                child: Text("ถนน: ${kanyangDocument["Road"]}"),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors
                                          .grey[300]!, // Adjust divider color
                                      width: 1.0, // Adjust divider thickness
                                    ),
                                  ),
                                ),
                                child: Text(
                                    "ตำบล: ${kanyangDocument["Subdistrict"]}"),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors
                                          .grey[300]!, // Adjust divider color
                                      width: 1.0, // Adjust divider thickness
                                    ),
                                  ),
                                ),
                                child: Text(
                                    "เบอร์ติดต่อ: ${kanyangDocument["TelNum"]}"),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors
                                          .grey[300]!, // Adjust divider color
                                      width: 1.0, // Adjust divider thickness
                                    ),
                                  ),
                                ),
                                child: Text(
                                    "แคมเปญ: ${kanyangDocument["campian"]}"
                                    ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors
                                          .grey[300]!, // Adjust divider color
                                      width: 1.0, // Adjust divider thickness
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "ข่าวสาร: ${kanyangDocument["News"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                        14, 
                                    color: Colors.black87, 
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
