import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderSend extends StatefulWidget {
  @override
  _OrderSendState createState() => _OrderSendState();
}

class _OrderSendState extends State<OrderSend>with SingleTickerProviderStateMixin  {
 late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายการขายยาง"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "ส่งคำสั่งขาย"),
            Tab(text: "รับยางพาราแล้ว"),
            Tab(text: "โอนเงินให้ชาวสวน"),
          ],
        ),
      ),
       body: TabBarView(
        controller: _tabController,
        children: [
          buildTabContent("ส่งคำสั่งขาย"),
          buildTabContent("รับยางพาราแล้ว"),
          buildTabContent("โอนเงินให้ชาวสวน"),
        ],
      ),
    );
  }
 Widget buildTabContent(String status) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("orderrequet")
          .where("status", isEqualTo: status) // กรองตามสถานะ
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs.map<Widget>((orderrequetDocument) {
            return status == orderrequetDocument["status"]
                ? Padding(
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
                            Text(
                                "เวลาที่เลือก: ${orderrequetDocument["time"]}"),
                            Text(
                                "ร้านรับซื้อ: ${orderrequetDocument["store"]}"),
                            Text("ราคา: ${orderrequetDocument["price"]}"),
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
                  )
                : Container(); // ไม่แสดงอะไรเลยถ้าไม่ match กับสถานะ
          }).toList(),
        );
      },
    );
  }
}