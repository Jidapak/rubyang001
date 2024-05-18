import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Quanlity extends StatefulWidget {
  @override
  _QuanlityState createState() => _QuanlityState();
}

class _QuanlityState extends State<Quanlity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "คุณภาพยาง",
          style: TextStyle(
            color: Colors.brown,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("calculateorders").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DataRow> rows = snapshot.data!.docs.map((document) {
            return DataRow(
              cells: [
                DataCell(
                  Text("${document["email"]}"),
                ),
                DataCell(
                  Text("${document["orderId"]}"),
                ),
                DataCell(
                  Text("${document["DRCpercent"]}"),
                ),
              ],
            );
          }).toList();

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'อีเมล์ชาวสวน',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'เลขคำสั่งขาย',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'เปอร์เซนต์DRC',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: rows,
            ),
          );
        },
      ),
    );
  }
}
