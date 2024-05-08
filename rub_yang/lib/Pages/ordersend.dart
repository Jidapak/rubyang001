import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderSend extends StatefulWidget {
  @override
  _OrderSendState createState() => _OrderSendState();
}

class _OrderSendState extends State<OrderSend> {
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
                            children: [Text(
                                  "วันนี้: ${orderrequetDocument["date"]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              SizedBox(height: 10),
                               Text(
                                    "เวลาที่เลือก: ${orderrequetDocument["time"]}"),
                              Text(
                                  "ร้านรับซื้อ: ${orderrequetDocument["store"]}"),
                              Text(
                                    "ราคา: ${orderrequetDocument["price"]}"),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors
                                          .brown,
                                      width: 1.0, // Adjust divider thickness
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
