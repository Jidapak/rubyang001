import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class displayprice extends StatefulWidget{
  @override
  _displaypriceState createState() => _displaypriceState();
}
class _displaypriceState extends State<displayprice>{
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ราคาแต่ละร้าน"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("prices").snapshots(),
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
                    'ชื่อร้าน',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'วันที่',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'แบบแผ่น',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'แบบก้อน',
                    style: TextStyle(
                      fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'แบบน้ำ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: snapshot.data!.docs.map<DataRow>((document) {
                DateTime todayDate =
                    (document["today_date"] as Timestamp).toDate();
                String formattedDate =
                    DateFormat('dd/MM/yyyy').format(todayDate);

                return DataRow(cells: [
                  DataCell(Text("${document["name_store"]}")),
                  DataCell(Text(formattedDate)),
                   DataCell(
                    Row(
                      children: [
                        Text("${document["update_pricesheet"]}"),
                        SizedBox(width: 5),
                        Text(
                          "(${document["pricsheet_diff"] > 0 ? '+' : ''}${document["pricsheet_diff"]})",
                          style: TextStyle(
                              color: document["pricsheet_diff"] > 0
                                  ? Colors.green
                                  : const Color.fromARGB(255, 196, 37,
                                      25)), 
                        ),
                      ],
                    ),
                  ),
                    DataCell(
                    Row(
                      children: [
                        Text("${document["update_pricechunk"]}"),
                        SizedBox(width: 5),
                        Text(
                          "(${document["pricchunk_diff"] > 0 ? '+' : ''}${document["pricchunk_diff"]})",
                          style: TextStyle(
                              color: document["pricchunk_diff"] > 0
                                  ? Colors.green
                                  : const Color.fromARGB(255, 196, 37,
                                      25)), 
                        ),
                      ],
                    ),
                  ),
                   DataCell(
                    Row(
                      children: [
                        Text("${document["update_pricewater"]}"),
                        SizedBox(width: 5),
                        Text(
                          "(${document["pricwater_diff"] > 0 ? '+' : ''}${document["pricwater_diff"]})",
                          style: TextStyle(
                              color: document["pricwater_diff"] > 0
                                  ? Colors.green
                                  : const Color.fromARGB(255, 196, 37,
                                      25)), 
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