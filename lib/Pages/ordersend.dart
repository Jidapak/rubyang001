import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderSend extends StatefulWidget {
  @override
  _OrderSendState createState() => _OrderSendState();
}

class _OrderSendState extends State<OrderSend>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Update the length to 3
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "กิจกรรมขายยาง",
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "รายการล่าสุด"),
            Tab(text: "รายการรับคำสั่งขาย"), // New tab
            Tab(text: "รายการย้อนหลัง"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildLatestTabContent(),
          buildAcceptedOrdersTabContent(), // Content for the new tab
          buildHistoryTabContent(),
        ],
      ),
    );
  }

  Widget buildLatestTabContent() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("orderrequet")
          .where("emailfarmer", isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .where("status", isEqualTo: "ส่งคำสั่งขาย")
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs.map<Widget>((orderrequetDocument) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "อีเมล์ชาวสวน: ${orderrequetDocument["emailfarmer"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "เลขที่คำสั่งขาย: ${orderrequetDocument.id}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("วันนี้: ${orderrequetDocument["date"]}"),
                      Text("เวลาที่เลือก: ${orderrequetDocument["time"]}"),
                      Text("ร้านรับซื้อ: ${orderrequetDocument["store"]}"),
                      Text("ราคา: ${orderrequetDocument["price"]}"),
                      Text("โอนเงินโดย: ${orderrequetDocument["_selectedPaymentMethod"]}"),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.brown,
                              width: 1.0, // Adjust divider thickness
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "สถานะ: ${orderrequetDocument["status"]}",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget buildAcceptedOrdersTabContent() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("orderrequet")
          .where("emailfarmer", isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .where("status", isEqualTo: "รับคำสั่งขาย") // Filter for accepted orders
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs.map<Widget>((orderrequetDocument) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "อีเมล์ชาวสวน: ${orderrequetDocument["emailfarmer"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "เลขที่คำสั่งขาย: ${orderrequetDocument.id}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("วันนี้: ${orderrequetDocument["date"]}"),
                      Text("เวลาที่เลือก: ${orderrequetDocument["time"]}"),
                      Text("ร้านรับซื้อ: ${orderrequetDocument["store"]}"),
                      Text("ราคา: ${orderrequetDocument["price"]}"),
                      Text("โอนเงินโดย: ${orderrequetDocument["_selectedPaymentMethod"]}"),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.brown,
                              width: 1.0, // Adjust divider thickness
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "สถานะ: ${orderrequetDocument["status"]}",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget buildHistoryTabContent() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("orderrequet")
          .where("emailfarmer", isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .where("status", whereIn: ["โอนเงินให้ชาวสวน", "ปฏิเสธออเดอร์"]) // Filter by multiple statuses
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs.map<Widget>((orderrequetDocument) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "อีเมล์ชาวสวน: ${orderrequetDocument["emailfarmer"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "เลขที่คำสั่งขาย: ${orderrequetDocument.id}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("วันนี้: ${orderrequetDocument["date"]}"),
                      Text("เวลาที่เลือก: ${orderrequetDocument["time"]}"),
                      Text("ร้านรับซื้อ: ${orderrequetDocument["store"]}"),
                      Text("ราคา: ${orderrequetDocument["price"]}"),
                      Text("รูปแบบจ่ายเงิน: ${orderrequetDocument["_selectedPaymentMethod"]}"),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.brown,
                              width: 1.0, // Adjust divider thickness
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "สถานะ: ${orderrequetDocument["status"]}",
                          style: TextStyle(
                            color: orderrequetDocument["status"] == "ปฏิเสธออเดอร์"
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
