import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class showprofile extends StatefulWidget {
  @override
  _showprofileState createState() => _showprofileState();
}

class _showprofileState extends State<showprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ประวัติชาวสวน"),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("farmerprofile").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            width: double.infinity,
            child: ListView(
              children: snapshot.data!.docs.map((profileDocument) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors
                          .white, 
                      border: Border.all(
                        color: Colors.brown,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), 
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Row(
                              children: [
                                SizedBox(width: 5),
                                Text(
                                  "ชื่อ ${profileDocument["NameF"]}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.brown[900]),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "สกุล ${profileDocument["NameL"]}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.brown[900]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ที่อยู่ ${profileDocument["Address"]}",
                                style: TextStyle(color: Colors.brown[900]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ตำบล ${profileDocument["Subdistrict"]}",
                                style: TextStyle(color: Colors.brown[900]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "อำเภอ${profileDocument["District"]}",
                                style: TextStyle(color: Colors.brown[900]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "จังหวัด${profileDocument["province"]}",
                            style: TextStyle(color: Colors.brown[900]),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "เบอร์โทร ${profileDocument["Teleph"]}",
                            style: TextStyle(color: Colors.brown[900]),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            "รายละเอียดบัญชีที่ต้องการให้โอนเงินเข้า",
                            style: TextStyle(
                                fontSize: 16, color: Colors.brown[900]),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "ชื่อบัญชี${profileDocument["accountname"]}",
                            style: TextStyle(color: Colors.brown[900]),
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "เลขบัญชี${profileDocument["accountno"]}",
                            style: TextStyle(color: Colors.brown[900]),
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "ชื่อธนาคาร${profileDocument["bankname"]}",
                            style: TextStyle(color: Colors.brown[900]),
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
