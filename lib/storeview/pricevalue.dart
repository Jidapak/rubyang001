import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceValue extends StatefulWidget {
  @override
  _PriceValueState createState() => _PriceValueState();
}

class _PriceValueState extends State<PriceValue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ราคากลางของการยาง",
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("centerprices").orderBy("today_date", descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'วันที่',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ยางก้อน',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ยางน้ำ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ยางแผ่น',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: snapshot.data!.docs.map<DataRow>((document) {
                Timestamp timestamp = document["today_date"] as Timestamp;
                DateTime dateTime = timestamp.toDate();
                String formattedDate =
                    DateFormat('dd/MM/yyyy').format(dateTime);
                return DataRow(cells: [
                  DataCell(Text(formattedDate)),
                  DataCell(
                    Row(
                      children: [
                        Text("${document["update_price_chunk"]}"),
                        SizedBox(width: 5),
                        Text(
                          "(${document["price_diff_chunk"] > 0 ? '+' : ''}${document["price_diff_water"]})",
                          style: TextStyle(
                              color: document["price_diff_chunk"] > 0
                                  ? Colors.green
                                  : const Color.fromARGB(255, 196, 37,
                                      25)), // Adjust color based on positive or negative difference
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        Text("${document["update_price_water"]}"),
                        SizedBox(width: 5),
                        Text(
                          "(${document["price_diff_water"] > 0 ? '+' : ''}${document["price_diff_water"]})",
                          style: TextStyle(
                              color: document["price_diff_water"] > 0
                                  ? Colors.green
                                  : const Color.fromARGB(255, 196, 37,
                                      25)), // Adjust color based on positive or negative difference
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        Text("${document["update_price_sheet"]}"),
                        SizedBox(width: 5),
                        Text(
                          "(${document["price_diff_sheet"] > 0 ? '+' : ''}${document["price_diff_water"]})",
                          style: TextStyle(
                              color: document["price_diff_sheet"] > 0
                                  ? Colors.green
                                  : const Color.fromARGB(255, 196, 37,
                                      25)), // Adjust color based on positive or negative difference
                        ),
                      ],
                    ),
                  ),
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
