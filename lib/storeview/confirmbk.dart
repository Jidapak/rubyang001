import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rub_yang/storeview/formrubyang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfirmBK extends StatefulWidget {
  @override
  _ConfirmBKState createState() => _ConfirmBKState();
}

class _ConfirmBKState extends State<ConfirmBK> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายการขายยาง"),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("orderrequet").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: snapshot.data!.docs.map<Widget>((orderrequetDocument) {
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
                              Text(
                                "อีเมล์ชาวสวน: ${orderrequetDocument["emailfarmer"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                               SizedBox(height: 10),
                               Text(
                                  "เลขที่คำสั่งขาย: ${orderrequetDocument.id}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              SizedBox(height:5),
                              Text("วันนี้: ${orderrequetDocument["date"]}"),
                              Text(
                                  "เวลาที่เลือก: ${orderrequetDocument["time"]}"),
                              Text(
                                  "ร้านรับซื้อ: ${orderrequetDocument["store"]}"),
                              Text("ราคา: ${orderrequetDocument["price"]} บาท"),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.brown,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                    "สถานะ: ${orderrequetDocument["status"]}"),
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
