import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rub_yang/storeview/formrubyang.dart';

class OrderCust extends StatefulWidget {
  @override
  _OrderCustState createState() => _OrderCustState();
}

class _OrderCustState extends State<OrderCust> {
  late String currentUserEmail;
  late String storeName = ""; // Initialize storeName with a default value

  @override
  void initState() {
    super.initState();
    getCurrentUserEmail();
  }

  Future<void> getCurrentUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserEmail = user.email!;
        storeName = currentUserEmail == "lekin@gmail.com" ? "เล็กอิน" : "โกโหน่ง";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "รายการขายยาง",
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("orderrequet")
            .where("store", isEqualTo: storeName) // Filter based on store name
            .snapshots(),
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
                bool isOrderCompleted = orderrequetDocument["status"] == "รับยางพาราแล้ว";

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
                                "เลขที่คำสั่งขาย ${orderrequetDocument.id}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text("วันนี้: ${orderrequetDocument["date"]}"),
                              Text("เวลาที่เลือก: ${orderrequetDocument["time"]}"),
                              Text("ร้านรับซื้อ: ${orderrequetDocument["store"]}"),
                              Text("ราคา: ${orderrequetDocument["price"]} บาท"),
                              Text(
                                "ชนิดยาง: ${orderrequetDocument["rubberType"]}",
                              ),
                              Text(
                                "วิธีชำระเงิน: ${orderrequetDocument["_selectedPaymentMethod"]}",
                              ),
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
                                  "สถานะ: ${orderrequetDocument["status"]}",
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: isOrderCompleted ||
                                              orderrequetDocument["status"] == "รับคำสั่งขาย" ||
                                              orderrequetDocument["status"] == "โอนเงินให้ชาวสวน"
                                          ? null
                                          : () async {
                                              await FirebaseFirestore.instance
                                                  .collection("orderrequet")
                                                  .doc(orderrequetDocument.id)
                                                  .update({
                                                "status": "รับคำสั่งขาย"
                                              });
                                            },
                                      style: ElevatedButton.styleFrom(
                                        primary: isOrderCompleted ||
                                                orderrequetDocument["status"] == "รับคำสั่งขาย" ||
                                                orderrequetDocument["status"] == "โอนเงินให้ชาวสวน"
                                            ? Colors.grey
                                            : Colors.green[700],
                                      ),
                                      child: Text(
                                        "ยืนยันการซื้อขาย",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: isOrderCompleted ||
                                              orderrequetDocument["status"] == "รับคำสั่งขาย" ||
                                              orderrequetDocument["status"] == "โอนเงินให้ชาวสวน"
                                          ? null
                                          : () async {
                                              await FirebaseFirestore.instance
                                                  .collection("orderrequet")
                                                  .doc(orderrequetDocument.id)
                                                  .update({
                                                "status": "ปฏิเสธออเดอร์"
                                              });
                                            },
                                      style: ElevatedButton.styleFrom(
                                        primary: isOrderCompleted ||
                                                orderrequetDocument["status"] == "รับคำสั่งขาย" ||
                                                orderrequetDocument["status"] == "โอนเงินให้ชาวสวน"
                                            ? Colors.grey
                                            : Colors.red[700],
                                      ),
                                      child: Text(
                                        "ปฏิเสธ",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: isOrderCompleted
                                          ? null
                                          : orderrequetDocument["status"] == "รับคำสั่งขาย"
                                              ? () async {
                                                  await FirebaseFirestore.instance
                                                      .collection("orderrequet")
                                                      .doc(orderrequetDocument.id)
                                                      .update({
                                                    "status": "รับยางพาราแล้ว"
                                                  });
                                                  setState(() {}); // Refresh the state to update button appearances
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Formrubyang(
                                                        selectedStoreName:
                                                            orderrequetDocument[
                                                                "store"],
                                                        selectedPaymentMethod:
                                                            orderrequetDocument[
                                                                "_selectedPaymentMethod"],
                                                        priceSheets:
                                                            orderrequetDocument[
                                                                "price"],
                                                        Type:
                                                            orderrequetDocument[
                                                                "rubberType"],
                                                        orderId:
                                                            orderrequetDocument.id,
                                                        email:
                                                            orderrequetDocument[
                                                                "emailfarmer"],
                                                      ),
                                                    ),
                                                  );
                                                }
                                              : null,
                                      style: ElevatedButton.styleFrom(
                                        primary: isOrderCompleted
                                            ? Colors.grey
                                            : Colors.brown,
                                      ),
                                      child: Text(
                                        "รับยางพาราแล้ว",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
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
