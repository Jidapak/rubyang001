import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class displayprice extends StatefulWidget {
  @override
  _displaypriceState createState() => _displaypriceState();
}

class _displaypriceState extends State<displayprice> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "ราคาและที่อยู่แต่ละร้าน",
            style: TextStyle(
              color: Colors.brown,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'ราคาแต่ละร้าน'),
              Tab(text: 'ที่อยู่แต่ละร้าน'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PriceList(priceType: 'แผ่น'), // First tab view
            AddTab(), // Second tab view
          ],
        ),
      ),
    );
  }
}
class PriceList extends StatelessWidget {
  final String priceType;

  PriceList({required this.priceType});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("prices")
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final document = snapshot.data!.docs[index];
            DateTime todayDate = DateTime.parse(document["date"]);
            String formattedDate =
                DateFormat('dd/MM/yyyy HH:mm').format(todayDate);
            
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ชื่อร้าน: ${document["storeName"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "วันที่: $formattedDate",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "อำเภอ: ${document["district"]}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "ราคากลาง: ${document["original_price"]}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "ราคาร้านนี้: ${document["adjusted_price"]} "
                      "(${document["adjusted_price"] > document["original_price"] ? '+' : ''}"
                      "${(document["adjusted_price"] - document["original_price"]).toStringAsFixed(2)})",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "รูปแบบยาง: ${document["type"]}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class AddTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("storeprofile").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          padding: EdgeInsets.all(8.0),
          children: snapshot.data!.docs.map((document) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document["NameStore"],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "ที่อยู่: ${document["Address"]} ตำบล: ${document["Subdistrict"]} อำเภอ: ${document["District"]}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "เบอร์ติดต่อ: ${document["Teleph"]}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
