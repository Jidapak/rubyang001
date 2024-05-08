import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListOrderReq extends StatefulWidget {
  @override
  _ListOrderReqState createState() => _ListOrderReqState();
}

class _ListOrderReqState extends State<ListOrderReq> with SingleTickerProviderStateMixin {
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
            Tab(text: "ส่งคำสั่งซื้อ"),
            Tab(text: "รับสินค้า"),
            Tab(text: "โอนเงินให้ชาวสวน"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrders("ส่งคำสั่งซื้อ"),
          _buildOrders("รับสินค้า"),
          _buildOrders("โอนเงินให้ชาวสวน"),
        ],
      ),
    );
  }

  Widget _buildOrders(String status) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("orderrequet").where("status", isEqualTo: status).snapshots(),
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
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                "วันนี้: ${orderrequetDocument["date"]}",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Text("เวลาที่เลือก: ${orderrequetDocument["time"]}"),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Text("ร้านรับซื้อ: ${orderrequetDocument["store"]}"),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Text("ราคา: ${orderrequetDocument["price"]}"),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1.0,
                                  ),
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
    );
  }
}
